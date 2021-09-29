import pandas as pd
import numpy as np
import random

'''
이 프로그램의 목적은 시나리오 1, 2, 3에 대응하는 사용자 정보 csv를 만드는 것이다
시나리오 1. 자신의 선호 카테고리의 책을 랜덤으로 읽는 사람
시나리오 2. 랜덤으로 읽는 사람
시나리오 3. 다른 사람이 읽은 책 중 일부를 따라 읽는 사람
사용자 수는 1,000 명을 만들 예정이며, 시나리오 1, 2, 3 순서대로 (400, 300, 300)명에 해당하는 좋아요 표시 데이터를 만드는 것이 목표이다.
'''

def get_books(path, file_name):
    df_books = pd.read_csv(path+file_name, encoding='cp949')
    df_books_category = pd.DataFrame(df_books, columns=['tag'])
    return df_books_category
def get_categories(path, file_name):
    df_category = pd.read_csv(path+file_name, encoding='cp949')
    df_category = df_category.dropna()  # NaN 제거
    list_category_count = np.array(df_category['count'].tolist())  # 리스트 생성
    list_category_count = list_category_count.astype(int)  # float64를 int로 변환
    return list_category_count

def scenario1(df_category_count):
    '''
    <시나리오 1 생성>
    400명 중 100명은 한 카테고리만 읽고, 나머지 300명은 274개 카테고리 중 1~10개 골라서 읽음
    책은 1개의 카테고리당 1~10권씩 읽음
    결과물은 like_category 에 들어있음
    '''
    # 한 카테고리만 읽은 100명의 좋아요 목록 생성
    like_category = []
    # 한 카테고리만 읽은 100명의 선호 장르가 선정됨
    for i in range(100):
        t = random.randint(0, len(df_category_count)-1)    # t번째 카테고리 선택
        tt = random.randint(1, min(df_category_count[t], 10))    # t번째 카테고리에서 tt개의 책을 읽음
        i_book_list = []                                # i번째 인원의 선호 리스트 저장
        for j in range(tt):
            a = random.randint(0, df_category_count[t]-1)
            while a in i_book_list:  # a가 이미 뽑은 리스트에 있을 때까지 다시 뽑자
                a = random.randint(0, df_category_count[t]-1)
            i_book_list.append(a)  # 새로운 a 값을 리스트에 추가
        b = 0
        for k in range(t):
            b += df_category_count[k]
        like_category.append(list(map(lambda x:x+b, i_book_list)))

    # 여러 카테고리를 읽은 300명의 선호 장르도 like_category 리스트에 추가
    for z in range(300):
        n = random.randint(2, 10)
        category_var = []
        i_book_list = []                                # i번째 인원의 선호 리스트 저장
        for i in range(n):
            t = random.randint(0, len(df_category_count)-1)    # t번째 카테고리 선택
            while t in category_var:
                t = random.randint(0, len(df_category_count)-1)
            category_var.append(t)                          # 카테고리 종류 저장


            tt = random.randint(1, min(df_category_count[t], 10))    # t번째 카테고리에서 tt개의 책을 읽음
            j_book_list = []
            for j in range(tt):
                a = random.randint(0, df_category_count[t]-1)
                while a in j_book_list:                     # 이미 선택한 책이 선택되면 다시 선택
                    a = random.randint(0, df_category_count[t]-1)
                j_book_list.append(a)
            b = 0
            for k in range(t-1):
                b += df_category_count[k]
            i_book_list += list(map(lambda x:x+b, j_book_list))
        like_category.append(i_book_list)
    return like_category
def scenario2(len_books):
    '''
        <시나리오 2 생성>
        300명은 5~50권의 책을 읽음
        결과물은 like_category 에 들어있음
        '''
    like_category = []
    for i in range(300):
        i_book_list = []
        t = random.randint(5, 50)   # i번째 사용자는 t권 읽음
        for j in range(t):
            tt = random.randint(0, len_books-1)
            while tt in i_book_list:
                tt = random.randint(0, len_books-1)
            i_book_list.append(tt)
        like_category.append(i_book_list)
    return like_category
def scenario3(list_scenarios):
    '''
        <시나리오 3 생성>
        나머지 700명은 기존에 만든 700명의 책 리스트 중 일부를 읽음
        결과물은 like_category 에 들어있음
    '''
    like_category = []
    for i_list in list_scenarios:
        i_book_list = []
        t = random.randint(1, len(i_list))
        for i in range(t):
            tt = random.randint(0, len(i_list)-1)
            while i_list[tt] in i_book_list and len(i_list) < t:
                tt = random.randint(0, len(i_list) - 1)
            i_book_list.append(i_list[tt])
        like_category.append(i_book_list)
    return like_category

def make_dataframe(list_scenarios):
    to_df = {
        'name': range(len(list_scenarios)),
        'user_id': range(len(list_scenarios)),
        'email': range(len(list_scenarios)),
        'password': range(len(list_scenarios)),
        'interest_tag': range(len(list_scenarios)),
        'like':list_scenarios,
        'borrowed':list_scenarios
    }

    df = pd.DataFrame(to_df)
    df = df.fillna(0)
    return df

def user_generator(file_path, books_file_name, categories_file_name, users_file_name):
    books = get_books(file_path, books_file_name)
    list_category_count = get_categories(file_path, categories_file_name)

    list_scenario1 = scenario1(list_category_count)
    list_scenario2 = scenario2(len(books), list_category_count)
    list_scenario3 = scenario3(list_scenario1+list_scenario2)

    df = make_dataframe(list_scenario1+list_scenario2+list_scenario3)
    df.to_csv(file_path + users_file_name)

file_path = "C:/Users/admin/Documents/osam_ai/book_dataset/"
books_file_name = "rec_books_1.csv"
categories_file_name = "rec_category_1.csv"
users_file_name = "rec_user_1.csv"

user_generator(file_path, books_file_name, categories_file_name, users_file_name)