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
def make_train_set(path, users_file_name, books_file_name):
    df_users = pd.read_csv(path + users_file_name, encoding='cp949')
    df_users_name_like = pd.DataFrame(df_users, columns=['name', 'like'])        # ex. 5, [11,27, 1120]

    df_books = pd.read_csv(path + books_file_name, encoding='cp949')
    df_books_title_tag = pd.DataFrame(df_books, columns=['title', 'tag'])
    #df_tag = pd.DataFrame(df_books, columns=['tag'])

    train_set = []

    # 'like' column 에는 str 타입으로 목록이 저장되어 있으므로 list 로 변환
    str_name = list(np.array(df_users_name_like['name'].tolist()))
    str_like = list(np.array(df_users_name_like['like'].tolist()))
    for i in range(len(df_users_name_like)):
        str_like[i] = str_like[i].lstrip('[').rstrip(']')
        list_like = str_like[i].split(', ')
        list_like = list(map(int, list_like))
        for book_id in list_like:
            # @@@@@@@@@@@ 현재는 'like' 안에 book_id 를 넣었지만, title 로 바뀔 수 있음
            # [11, 27, 1120]
            df_book_title_tag = df_books_title_tag.iloc[book_id, :].tolist()
            title = df_book_title_tag[0]
            tags = df_book_title_tag[1]
            tags = tags.split(">")
            tags.remove("국내도서")
            for tag in tags:
                train_set.append((title, str_name[i], tag))



file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'  # 서버 폴더경로 맞춰서 다시 설정
users_file_name = "rec_user_1.csv"
books_file_name = "rec_books_1.csv"
pred_file_name = "rec_pred_score_1.csv"
traindata_name = "train_data_1.csv"
make_train_set(file_path, users_file_name, books_file_name, traindata_name)