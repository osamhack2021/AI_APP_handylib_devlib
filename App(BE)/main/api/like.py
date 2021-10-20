from flask import Blueprint,request,Response,json
from main.models import database

like_page=Blueprint('like',__name__)

@like_page.route('/',methods=['POST'])
def like_append():
    user_id = request.values.get('user_id')
    isbn = request.values.get('isbn')
    user=database.User.objects(user_id=user_id).first()
    lists=user.like
    for item in lists:
        if item==isbn:
            lists.remove(isbn)
            user.update(like=lists)
            resultJson=json.dumps({"message": 'delete'})
            return Response(resultJson,mimetype="application/json",status=200)
    lists.append(isbn)
    user.update(like=lists)
    resultJson=json.dumps({"message": 'append'})
    # 서버 추천 코드
    from main.recommendation import data_update
    data_update.update()
    return Response(resultJson,mimetype="application/json",status=200)

@like_page.route('/',methods=['GET'])
def like_get():
    user_id = request.values.get('user_id')
    isbn = request.values.get('isbn')        
    user=database.User.objects(user_id=user_id).first()
    if user:
        for item in user.like:
            if item==isbn:
                resultJson=json.dumps({"message": "True"})
                return Response(resultJson,mimetype="application/json",status=200)
    resultJson=json.dumps({"message": "False"})
    return Response(resultJson,mimetype="application/json",status=200)