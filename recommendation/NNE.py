# NNE 생성
from keras.layers import Input, Embedding, Dot, Reshape, Dense
from keras.models import Model
import numpy as np
import pandas as pd
import random

'''
NNE 설명글 train set
Book Title: 'The Better Angels of Our Nature'
Wikilinks:
['Steven Pinker',
  'Nation state',
  'commerce',
  'literacy',
  'Influence of mass media',
  'Rationality',
  "Abraham Lincoln's first inaugural address",
  'nature versus nurture',
  'Leviathan']
-----------------------------------------------------------
NNE 적용
(book id, 사용자 id, 태그)를 만들어야 한다...
rec_user_1.csv 로부터,
user_x 의 like list 를 받아오고,
like list 에서 book_id 하나를 꺼내고,
book_id 에서 tag 를 분해 후, 태그를 하나씩 돌리며
train_set.append((book_id, user_id, tag)) 를 한다
'''
def make_pairs(path, users_file_name, books_file_name):
    df_users = pd.read_csv(path + users_file_name, encoding='cp949')
    df_users_name_like = pd.DataFrame(df_users, columns=['name', 'like'])        # ex. 5, [11,27, 1120]

    df_books = pd.read_csv(path + books_file_name, encoding='cp949')
    df_books_title_tag = pd.DataFrame(df_books, columns=['title', 'tag'])

    title_index = {title: idx for idx, title in enumerate(df_books_title_tag['title'])}
    name_index = {name: idx for idx, name in enumerate(df_users_name_like['name'])}
    tags = df_books_title_tag['tag']
    tags = list(map(lambda x: x.split(">"), tags))
    list_tag = []
    for i in range(len(tags)):
        tags[i].remove("국내도서")
        list_tag += tags[i]
    tag_index = dict()
    idx = 0
    for _, tag in enumerate(list_tag):
        if not tag in tag_index:
            tag_index[tag] = idx
            idx += 1


    # true dataset 만들기
    train_true = []
    dict_tag = dict()
    # 'like' column 에는 str 타입으로 목록이 저장되어 있으므로 list 로 변환
    str_name = list(np.array(df_users_name_like['name'].tolist()))
    str_like = list(np.array(df_users_name_like['like'].tolist()))
    for i in range(len(df_users_name_like)):
        str_like[i] = str_like[i].lstrip('[').rstrip(']')
        list_like = str_like[i].split(', ')
        list_like = list(map(int, list_like))
        for book_id in list_like:
            # @@@@@@@@@@@ 현재는 'like' 안에 book_id 를 넣었지만, title 로 바뀔 수 있음 @@@@@@@@@@@
            # [11, 27, 1120]
            df_book_title_tag = df_books_title_tag.iloc[book_id, :].tolist()
            title = df_book_title_tag[0]
            tags = df_book_title_tag[1]
            tags = tags.split(">")
            tags.remove("국내도서")
            for tag in tags:
                train_true.append((title_index[title], name_index[str_name[i]], tag_index[tag]))
    df_train = pd.DataFrame(train_true)
    df_train.to_csv(file_path + "train.csv")

    return train_true, title_index, name_index, tag_index

def generate_batch(pairs, file_path, users_file_name, books_file_name, n_positive = 50, negative_ratio = 1.0):
    """Generate batches of samples for training.
       Random select positive samples
       from pairs and randomly select negatives."""

    # batch를 저장할 numpy 배열을 준비합니다.
    batch_size = n_positive * (1 + negative_ratio)
    batch = np.zeros((batch_size, 4))

    # random 에 사용할 title, name, tag 리스트 준비
    df_users = pd.read_csv(file_path + users_file_name, encoding='cp949')
    df_books = pd.read_csv(file_path + books_file_name, encoding='cp949')

    df_title = pd.DataFrame(df_books, columns=['title'])
    df_name = pd.DataFrame(df_users, columns=['name'])
    df_tag = pd.DataFrame(df_books, columns=['tag'])

    title = list(np.array(df_title['title'].tolist()))
    name = list(np.array(df_name['name'].tolist()))
    tag = list(np.array(df_tag['tag'].tolist()))
    tag = list(map(lambda x: x.split(">"), tag))
    tags = []
    for i in tag:
        i = i.remove("국내도서")
        tags.append(i)

    while True:
        # 랜덤으로 True인 샘플을 준비합니다.
        idx = 0
        for idx, (title_id, name_id, tag_id) in enumerate(random.sample(pairs, n_positive)):
            batch[idx, :] = (title_id, name_id, tag_id, 1)
        print(idx)
        idx += 1
        print(idx)
        # 배치 사이즈가 다 찰 때까지 False인 샘플을 추가합니다.
        while idx < batch_size:

            # Random selection
            random_book_title = random.randrange(len(title))
            random_user_name = random.randrange(len(name))
            random_book_tag = random.randrange(len(tags))

            # Ture인 샘플이 아니라는 것(False인 샘플이라는 것)을 체크합니다.
            if (random_book_title, random_user_name, random_book_tag) not in pairs:

                # False인 샘플을 배치에 추가합니다.
                batch[idx, :] = (random_book_title, random_user_name, random_book_tag, 0)   # 0 means negative label
                idx += 1

        # 배치에 저장된 데이터들의 순서를 섞습니다.
        np.random.shuffle(batch)
        yield {'title': batch[:, 0], 'name': batch[:, 1], 'tag': batch[:, 2]}, batch[:, 3]

def book_embedding_model(embedding_size = 50, classification = False):
    """Model to embed books and wikilinks using the Keras functional API.
       Trained to discern if a link is present in on a book's page"""
    # 1차원의 입력
    title = Input(name = 'title', shape = [1])
    name = Input(name = 'name', shape = [1])
    tag = Input(name='tag', shape=[1])

    # 책 임베딩 (shape will be (None, 1, 50))
    title_embedding = Embedding(name = 'book_embedding',
                               input_dim = len(title_index),
                               output_dim = embedding_size)(title)

    # 링크 임베딩 (shape will be (None, 1, 50))
    name_embedding = Embedding(name = 'link_embedding',
                               input_dim = len(name_index),
                               output_dim = embedding_size)(name)

    tag_embedding = Embedding(name='tag_embedding',
                               input_dim=len(tag_index),
                               output_dim=embedding_size)(tag)

    # 내적으로 책 임베딩과 링크 임베딩을 한 개의 임베딩 벡터로 변형
    # (shape will be (None, 1, 1))
    merged1 = Dot(name = 'dot_product1', normalize = True,
                 axes = 2)([title_embedding, name_embedding])
    merged2 = Dot(name = 'dot_product2', normalize = True,
                 axes = 2)([name_embedding, tag_embedding])
    merged3 = Dot(name='dot_product3', normalize=True,
                  axes=2)([tag_embedding, title_embedding])

    merged = merged1 * merged2 * merged3


    # 단일 숫자로 shape 변형 (shape will be (None, 1))
    merged = Reshape(target_shape = [1])(merged)

    # 분류를 위한 결과값 출력
    out = Dense(1, activation = 'sigmoid')(merged)
    model = Model(inputs = [title, name, tag], outputs = out)

    # 원하는 optimizer 와 loss 함수로 모델 학습 시작
    model.compile(optimizer = 'Adam', loss = 'binary_crossentropy',
                  metrics = ['accuracy'])

    return model

file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'  # 서버 폴더경로 맞춰서 다시 설정
users_file_name = "rec_user_1.csv"
books_file_name = "rec_books_1.csv"
pred_file_name = "rec_pred_score_1.csv"
traindata_name = "train_data_1.csv"


pairs, title_index, name_index, tag_index = make_pairs(file_path, users_file_name, books_file_name)

n_positive = 1024
gen = generate_batch(pairs, file_path, users_file_name, books_file_name, n_positive, negative_ratio = 2)

model = book_embedding_model()
model.summary()

# Train
h = model.fit_generator(gen, epochs = 15,
                        steps_per_epoch = len(pairs) // n_positive)