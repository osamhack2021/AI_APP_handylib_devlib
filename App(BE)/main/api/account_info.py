from flask import Blueprint,request,Response,json
from main.models import database
info_page=Blueprint('info',__name__)

@info_page.route('/',methods=['GET'])
def info():
    user_id=request.values.get('user_id')
    if user_id:
        user=database.User.objects(user_id=user_id).first()
        if user:
            user.to_json()
            resultJson=json.dumps(user, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=200)
    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)

@info_page.route('/edit',methods=['PUT'])
def info_edit():
    params=request.get_json()
    user_id=request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            email = params['email']
            name = params['name']
            unit = params['unit']
            rank = params['rank']
            password=params['password']
            user.update(email=email, name= name, unit=unit, rank=rank,password=password)
            resultJson=json.dumps({"message": "edit success"})
            return Response(resultJson,mimetype="application/json",status=200)
    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)
