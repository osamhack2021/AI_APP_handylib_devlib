from flask import Blueprint,request,session,json,Response
from main.models import database
sign_in_page=Blueprint('sign_in',__name__)

@sign_in_page.route('/',methods=['POST'])
def sign_in():

    user_id = request.form.get('user_id')
    pwd = request.form.get('password')
    users = database.User.objects(user_id=user_id).first()
    if not users:
        #response형태로 id 잘못 입력 보내기
        resultJson=json.dumps({"message": "login failed"})
        return Response(resultJson,mimetype="application/json",status=401)
    else:
        if users.password == pwd:
            session["user_id"] = user_id
            session["name"] = users.name
            session.permanent = True
            #성공시 response 200 status
            resultJson=json.dumps({"message": "login success"})
            return Response(resultJson,mimetype="application/json",status=200)
        #실패시 response형태로 pwd 잘못 입력 보내기
        resultJson=json.dumps({"message": "login failed"})
        return Response(resultJson,mimetype="application/json",status=401)