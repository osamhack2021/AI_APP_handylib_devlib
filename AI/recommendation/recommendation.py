import numpy as np
import pandas as pd

def get_ratings(path, users_file_name):
    df_users = pd.read_csv(path + users_file_name, encoding='UTF8')
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

    for user_idx in range(len(df_users_books['user_id'])):
        for book_idx in list_like[user_idx]:
            sr_users.append(user_idx)
            sr_books.append(book_idx)
            sr_ratings.append(1)

    R = pd.DataFrame({
        'user_idx': sr_users,
        'book_idx': sr_books,
        'ratings': sr_ratings
    })

    R = R.pivot_table('ratings', index='user_idx', columns='book_idx').fillna(0)
    R.rename(columns= lambda x: int(x), inplace=True)
    R = R.sort_index(axis=1)
    return R

def recommendation(file_path, save_path, users_file_name, books_file_name, rec_file_name, user_id):
    pred_file_name = "rec_pred_score_1.csv"      # 환경에 맞게 수정
    df_preds = pd.read_csv(file_path + pred_file_name, encoding='UTF8').fillna(0)
    df_preds.drop(['Unnamed: 0'], axis=1, inplace=True)
    df_books = pd.read_csv(file_path + books_file_name, encoding='UTF8')
    df_books = pd.DataFrame(df_books, columns=['isbn', 'isbn13', 'title'])
    # df_books = pd.DataFrame(df_books, columns=['isbn', 'title', 'tag']

    try:
        pred_row_idx = df_preds.index[df_preds['user_id']==user_id]
        pred_row = df_preds.iloc[pred_row_idx]
    except:
        df_recommendation_newUser = df_books.sample(n=30, replace=False)
        df_recommendation_newUser.to_csv(file_path + save_path + rec_file_name)
        return

    pred_row.index.name = 'book_id'
    list_pred_row = list(np.array(pred_row.tolist()))

    df = pd.DataFrame({ 'pred_score':list_pred_row
    })
    df = pd.concat([df, df_books], axis = 1)
    df = df.sort_values(by='pred_score', ascending=False)
    df_recommendation = df.iloc[range(30)]
    df_recommendation = pd.DataFrame(df_recommendation, columns=['isbn', 'isbn13', 'title'])
    df_recommendation.to_csv(file_path + save_path + rec_file_name)