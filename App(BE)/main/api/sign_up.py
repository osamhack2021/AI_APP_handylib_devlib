#sign_up blueprint
from flask import Blueprint, request, json, Response
from main.models import database

sign_up_page = Blueprint('sign_up', __name__)


@sign_up_page.route('/', methods=['POST'])
def sign_up():
    #user_id가 일치하는게 db에 있는지 확인
    params=request.get_json()
    user = database.User.objects(
        user_id=params['user_id']).first()
    if user:
        resultJson=json.dumps({"message": "user already exists"})
        return Response(resultJson,mimetype="application/json",status=403)
    database.User(
        user_id=params['user_id'],
        password=params['password'],
        name=params['name'],
        email=params['email'],
        rank=params['rank'],
        unit=params['unit']
    ).save()
    # 서버 추천 코드
    user_id=params['user_id']
    from main.recommendation import recommendation
    import pandas as pd
    file_path = '/var/www/python_flask/main/recommendation/'  # 서버 폴더경로 맞춰서 다시 설정
    save_path = 'recommend_list/'
    users_file_name = "API_test_users.csv"
    books_file_name = "API_test_books.csv"
    rec_file_name=user_id+'.csv'
    df_users = pd.read_csv(file_path + users_file_name, encoding='utf-8')
    recommendation.recommendation(file_path, save_path, users_file_name, books_file_name, rec_file_name, user_id)
    resultJson=json.dumps({"message": "sign_up success"})
    return Response(resultJson,mimetype="application/json",status=200)
