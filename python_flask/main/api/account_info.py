from flask import Blueprint,request,Response,json
from main.models import database
info_page=Blueprint('info',__name__)

@info_page.route('/',methods=['GET'])
def info():
    user_id=request.args.get('user_id')
    if not user_id:
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    user=database.User(user_id=user_id).objects.first().to_json()
    resultJson=json.dumps(user, ensure_ascii=False)
    # user 정보 전체
    return Response(resultJson,mimetype="application/json",status=200)

@info_page.route('/edit',methods=['PUT'])
def info_edit():
    params=request.get_json()
    user_id=request.args.get('user_id')
    if not user_id:
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    # req user 객체명 필요!
    email=params['email']
    name=params['name']
    unit=params['unit']
    rank=params['rank']
    user=database.User.objects(user_id=user_id).first()
    user.update(email=email, name= name, unit=unit, rank=rank)
    # 수정 여부 확인 메시지
    resultJson=json.dumps({"message": "edit success"})
    return Response(resultJson,mimetype="application/json",status=200)