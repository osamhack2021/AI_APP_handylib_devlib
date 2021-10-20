from .ALS import predict

def update():
    file_path = '/var/www/python_flask/main/recommendation/'
    users_file_name = 'API_test_users.csv'
    books_file_name = 'API_test_books.csv'
    pred_file_name = "rec_pred_score_1.csv"
    predict(file_path, users_file_name, books_file_name, pred_file_name)