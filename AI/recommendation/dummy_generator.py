import pandas as pd
import random

file_path = '/var/www/python_flask/main/recommendation/'  # 서버 폴더경로 맞춰서 다시 설정
save_path = 'recommend_list/'
users_file_name = "dummy_users.csv"
books_file_name = "API_test_books.csv"
categories_file_name = "rec_category_2.csv"

df_books = pd.read_csv(file_path + books_file_name, encoding='cp949')
df_category = pd.read_csv(file_path + categories_file_name, encoding='cp949')
df_category = df_category[['category', 'count']].dropna()

def make_like_list(category):
    cat_idx = category
    cat_count = df_category.iloc[cat_idx]['count']
    book_list = list(df_books.index[df_books['categoryName'] == df_category.iloc[cat_idx]['category']])
    pick_count = random.randint(1, min(10, cat_count))
    like_list = []
    for i in range(pick_count):
        pick_idx = random.randint(0, cat_count-1)
        cnt = 0
        while book_list[pick_idx] in like_list and cnt < 10:
            pick_idx = random.randint(0, cat_count - 1)
        if cnt < 10:
            like_list.append(book_list[pick_idx])
    return like_list

def make_like_category():
    cat_len = len(df_category)
    cat_num = random.randint(1, min(10, cat_len))
    cat_list = []
    like_list = []
    for i in range(cat_num):
        pick_cat = random.randint(0, cat_len-1)
        cnt = 0
        while pick_cat in cat_list and cnt < 10:
            pick_cat = random.randint(0, cat_len - 1)
        if cnt < 10:
            cat_list.append(pick_cat)

    for category in cat_list:
        like_list += make_like_list(category)

    return like_list

like_list = []
for i in range(50):
    like_list.append(make_like_category())

def make_dataframe(like_list):
    n = len(like_list)
    list_unit = []
    list_rank = []
    list_user_id = []

    int_rank = ['이등병', '일병', '상병', '병장']
    for i in range(n):
        list_unit.append("53사단" if random.randint(0, 1) else "31사단")
        list_rank.append(int_rank[random.randint(0, 3)])

    for i in range(n):
        list_user_id.append('userid_'+str(i))

    to_df = {
        'name': range(n),
        'email': range(n),
        'password': range(n),
        'user_id': list_user_id,
        'like':like_list,
        'rank': list_rank,
        'unit': list_unit
    }

    df = pd.DataFrame(to_df)
    df = df.fillna(0)
    return df

df = make_dataframe(like_list)
df.to_csv(file_path + users_file_name)