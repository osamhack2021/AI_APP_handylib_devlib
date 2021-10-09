from Alternating_Least_Squares import predict
from recommendation import recommendation
import pandas as pd
# import numpy as np

def updater(file_path, users_file_name, books_file_name):
    # file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'  # 서버 폴더경로 맞춰서 다시 설정
    # users_file_name = "rec_user_1.csv"
    # books_file_name = "rec_books_1.csv"
    pred_file_name = "rec_pred_score_1.csv"
    df_users = pd.read_csv(file_path + users_file_name, encoding='cp949')

    predict(file_path, users_file_name, pred_file_name)
    for i in range(len(df_users)):
        rec_file_name = str(i).zfill(5) + ".csv"
        recommendation(file_path, users_file_name, books_file_name, pred_file_name, rec_file_name, user_id=i)