import os
import sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))))
from main.models import database
import pandas as pd
import numpy as np

def update():
    '''
    books = database.Book.objects()
    isbn = []
    for b in books:
        isbn.append(b.isbn)
    '''
    file_path = '/var/www/python_flask/main/recommendation/'
    books_file_name = 'API_test_books.csv'
    df_books = pd.read_csv(file_path + books_file_name)
    isbn = list(np.array(df_books['isbn']).tolist())

    dummy_file_name = 'dummy_users.csv'
    df_dummy_user = pd.read_csv(file_path + dummy_file_name)

    users = database.User.objects()
    name = []
    email = []
    password = []
    user_id = []
    like = []
    rank = []
    unit = []
    for u in users:
        t_list = []
        for l in u.like:
            t = l.rstrip('/')
            try:
                t = isbn.index(t)
            except:
                continue
            t_list.append(t)
        like.append(t_list)
        name.append(u.name)
        email.append(u.email)
        password.append(u.password)
        user_id.append(u.user_id)
        rank.append(u.rank)
        unit.append(u.unit)

    to_df = {
            'name': name,
            'email': email,
            'password': password,
            'user_id': user_id,
            'like':like,
            'rank': rank,
            'unit': unit
    }

    df = pd.DataFrame(to_df)
    df = df.fillna(0)
    df = pd.concat([df, df_dummy_user], ignore_index=True)
    df.to_csv('/var/www/python_flask/main/recommendation/API_test_users.csv')
    return