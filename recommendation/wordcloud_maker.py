from wordcloud import WordCloud
from wordcloud import STOPWORDS

import pandas as pd
import numpy as np
import os, shutil

def make_wordcloud(file_path, users_file_name, books_file_name, user_id):
    stopwords = set(STOPWORDS)
    stopwords.add("국내도서")
    df_users = pd.read_csv(file_path + users_file_name, encoding='cp949')
    df_users_like_borrowed_interesttags = pd.DataFrame(df_users, columns=['user_id', 'like', 'borrowed', 'interest_tag'])
    df_users_like_borrowed_interesttags = df_users_like_borrowed_interesttags[df_users_like_borrowed_interesttags['user_id']==user_id]

    str_like = list(np.array(df_users_like_borrowed_interesttags['like'].tolist()))
    i = str_like[0].lstrip('[').rstrip(']')
    i = i.split(', ')
    i = list(map(int, i))
    list_like = i

    df_books = pd.read_csv(file_path + books_file_name, encoding='cp949')
    df_books_tag = pd.DataFrame(df_books, columns=['tag'])
    df_books_tag = df_books_tag.iloc[list_like, :]

    list_books_tag = np.array(df_books_tag.iloc[:, 0].tolist())
    list_books_tag = list(map(lambda x:x.split('>'), list_books_tag))
    list_books_tag = sum(list_books_tag, [])
    str_books_tag = " ".join(list_books_tag)

    wc = WordCloud(font_path="C:/Users/admin/Documents/osam_ai/dev_rec/NanumFontSetup_TTF_BARUNPEN/NanumBarunpenR.ttf",
            background_color="white",
            width=1000,
            height=1000,
            max_words=100,
            max_font_size=300,
            stopwords=stopwords)

    wc.generate(str_books_tag)
    file_name = 'liketag_'+str(user_id)+'.png'
    wc.to_file(file_name)

    path = os.getcwd()
    shutil.move(path+"\\"+file_name, file_path)


file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'
users_file_name = "rec_user_1.csv"
books_file_name = "rec_books_1.csv"
user_id = 500
make_wordcloud(file_path, users_file_name, books_file_name, user_id)