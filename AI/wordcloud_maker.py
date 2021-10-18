from wordcloud import WordCloud
from wordcloud import STOPWORDS

import pandas as pd
import numpy as np

def make_wordcloud(file_path, save_path, font_path, users_file_name, books_file_name, user_id):
    stopwords = set(STOPWORDS)
    stopwords.add("국내도서")
    df_users = pd.read_csv(file_path + users_file_name, encoding='UTF8')
    df_users_like = pd.DataFrame(df_users, columns=['user_id', 'like'])
    df_users_like = df_users_like[df_users_like['user_id']==user_id]

    val = df_users_like['like'].head(1)
    val = list(np.array(val))
    if df_users_like.empty or val == ['[]']:
        df_books = pd.read_csv(file_path + books_file_name, encoding='UTF8')
        df_books_tag = pd.DataFrame(df_books, columns = ['categoryName'])

        list_books_tag = np.array(df_books_tag.iloc[:, 0].tolist())
        list_books_tag = list(map(lambda x: x.split('>'), list_books_tag))
        list_books_tag = sum(list_books_tag)
        str_books_tag = " ".join(list_books_tag)

        wc = WordCloud(font_path=font_path,
                       background_color='white',
                       width=400,
                       height=300,
                       max_words=200,
                       max_font_size=50,
                       stopwords=stopwords)

        wc. generate(str_books_tag)
        file_name = str(user_id) + '.png'
        wc.to_file(save_path + file_name)
        return

    str_like = list(np.array(df_users_like['like'].tolist()))
    i = str_like[0].lstrip('[').rstrip(']')
    i = i.split(', ')
    i = list(map(int, i))
    list_like = i

    df_books = pd.read_csv(file_path + books_file_name, encoding='UTF8')
    df_books_tag = pd.DataFrame(df_books, columns=['categoryName'])
    df_books_tag = df_books_tag.iloc[list_like, :]

    list_books_tag = np.array(df_books_tag.iloc[:, 0].tolist())
    list_books_tag = list(map(lambda x:x.split('>'), list_books_tag))
    list_books_tag = sum(list_books_tag, [])
    str_books_tag = " ".join(list_books_tag)

    wc = WordCloud(font_path=font_path,
            background_color="white",
            width=400,
            height=300,
            max_words=50,
            max_font_size=100,
            stopwords=stopwords)

    wc.generate(str_books_tag)
    file_name = str(user_id)+'.png'
    wc.to_file(save_path + file_name)

def exe_img(user_id):
    file_path = '/var/www/python_flask/main/recommendation/'
    save_path = '/var/www/python_flask/main/static/img/'
    users_file_name = "API_test_users.csv"
    books_file_name = "API_test_books.csv"
    font_path = "/var/www/python_flask/main/recommendation/NanumFontSetup_TTF_BARUNPEN/NanumBarunpenR.ttf"
    make_wordcloud(file_path, save_path, font_path, users_file_name, books_file_name, user_id)
