from .ALS import predict

def update():
    file_path = '/var/www/python_flask/main/recommendation/'    # 환경에 맞게 수정
    users_file_name = 'API_test_users.csv'                      # 환경에 맞게 수정
    books_file_name = 'API_test_books.csv'                      # 환경에 맞게 수정
    pred_file_name = "rec_pred_score_1.csv"                     # 환경에 맞게 수정
    predict(file_path, users_file_name, books_file_name, pred_file_name)