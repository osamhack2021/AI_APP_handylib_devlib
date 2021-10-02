import numpy as np
import pandas as pd

def get_ratings(path, users_file_name):
    df_users = pd.read_csv(path + users_file_name, encoding='cp949')
    df_users_books = pd.DataFrame(df_users, columns=['user_id', 'like'])
    sr_users = []
    sr_books = []
    sr_ratings = []
    str_like = list(np.array(df_users_books['like'].tolist()))
    list_like = []
    for i in str_like:
        i = i.lstrip('[').rstrip(']')
        i = i.split(', ')
        list_like.append(i)

    for user_id in df_users_books['user_id']:
        for book_id in list_like[user_id]:
            sr_users.append(user_id)
            sr_books.append(book_id)
            sr_ratings.append(1)

    R = pd.DataFrame({
        'user_id': sr_users,
        'book_id': sr_books,
        'ratings': sr_ratings
    })

    R = R.pivot_table('ratings', index='user_id', columns='book_id').fillna(0)
    R.rename(columns= lambda x: int(x), inplace=True)
    R = R.sort_index(axis=1)
    return R

def recommendation(file_path, users_file_name, books_file_name, pred_file_name, rec_file_name, user_id):
    df_preds = pd.read_csv(file_path + pred_file_name, encoding='cp949').fillna(0)
    df_preds.drop(['Unnamed: 0'], axis=1, inplace=True)
    df_ratings = get_ratings(file_path, users_file_name)
    df_books = pd.read_csv(file_path + books_file_name, encoding='cp949')
    df_books = pd.DataFrame(df_books, columns=['isbn', 'title'])
    # df_books = pd.DataFrame(df_books, columns=['isbn', 'title', 'tag']

    pred_row = df_preds.iloc[user_id]
    ratings_row = df_ratings.iloc[user_id]

    pred_row.index.name = 'book_id'
    list_pred_row = list(np.array(pred_row.tolist()))
    list_ratings_row = list(np.array(ratings_row.tolist()))

    df = pd.DataFrame({ 'pred_score':list_pred_row,
                        'like':list_ratings_row,
    })
    df = pd.concat([df, df_books], axis = 1)
    df = df.sort_values(by='pred_score', ascending=False)
    df_recommendation = df[df['like']==0]
    df_recommendation = df_recommendation.iloc[range(20)]
    df_recommendation = pd.DataFrame(df_recommendation, columns=['isbn', 'title'])
    # print(user_id)
    df_recommendation.to_csv(file_path + rec_file_name)

file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'  # 서버 폴더경로 맞춰서 다시 설정
users_file_name = "rec_user_1.csv"
books_file_name = "rec_books_1.csv"
pred_file_name = "rec_pred_score_1.csv"
df_users = pd.read_csv(file_path + users_file_name, encoding='cp949')

for i in range(1):  #len(df_users)):
    rec_file_name = str(i).zfill(5) + ".csv"
    recommendation(file_path, users_file_name, books_file_name, pred_file_name, rec_file_name, user_id=i)
