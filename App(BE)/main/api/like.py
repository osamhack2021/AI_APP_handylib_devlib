from flask import Blueprint,request,Response,json
from main.models import database

like_page=Blueprint('comment',__name__)

@like_page.route('/',methods=['POST'])
def like_append():
    user_id = request.values.get('user_id')
    isbn = request.values.get('isbn')
    user=database.User.objects(user_id=user_id).first()
    like=user.like
    like.append(isbn)
    user.upadate(like=like)
    resultJson=json.dumps({"message": "success"})
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
    return Response(resultJson,mimetype="application/json",status=404)