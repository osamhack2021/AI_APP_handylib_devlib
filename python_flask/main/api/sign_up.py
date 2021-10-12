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
    resultJson=json.dumps({"message": "sign_up success"})
    return Response(resultJson,mimetype="application/json",status=200)
