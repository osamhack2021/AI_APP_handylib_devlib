import wordcloud_maker
import recommendation
import update
import data_update
import pandas as pd

# wordcloud_maker 테스트 : save_path에 (user_id).png 이름의 취향분석 이미지 생성되는지 확인
file_path = '/var/www/python_flask/main/recommendation/'    # 환경에 맞게 수정
save_path = '/var/www/python_flask/main/static/img/'        # 환경에 맞게 수정
users_file_name = "API_test_users.csv"                      # 환경에 맞게 수정
books_file_name = "API_test_books.csv"                      # 환경에 맞게 수정
font_path = "/var/www/python_flask/main/recommendation/NanumFontSetup_TTF_BARUNPEN/NanumBarunpenR.ttf"  # 환경에 맞게 수정

user_id = 'kim12'
wordcloud_maker.make_wordcloud(file_path, save_path, font_path, users_file_name, books_file_name, user_id)

# recommendation 테스트 : save_path에 (user_id).csv 이름의 추천리스트 생성되는지 확인
file_path = '/var/www/python_flask/main/recommendation/'
save_path = 'recommend_list/'
users_file_name = "API_test_users.csv"
books_file_name = "API_test_books.csv"

df_users = pd.read_csv(file_path + users_file_name, encoding='UTF8')
user_id = 'userid_0'
rec_file_name = user_id + '.csv'
recommendation.recommendation(file_path, save_path, users_file_name, books_file_name, rec_file_name, user_id)

# update.py, ALS.py 테스트 : ALS.py에서 추천점수 (rec_file_1.csv)가 최신화 되는지 확인
update.update()

# data_update.py 테스트 : API_users_file이 DB의 사용자 정보에 맞게 최신화되는지 확인
data_update.update()