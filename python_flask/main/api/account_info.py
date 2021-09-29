from main.api import login_require
from flask import Blueprint,request,session,redirect,Response,json
from main.models import database
info_page=Blueprint('info',__name__)

@info_page.route('/',methods=['GET'])
@login_require
def info():
    user_id=session.get('user_id')
    user=database.User(user_id=user_id).objects.first().to_json()
    resultJson=json.dumps(user, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@info_page.route('/edit',methods=['PUT'])
@login_require
def info_edit():
    email=request.form.get('email')
    interest_tag=request.form.get('interest_tag')
    name=request.form.get('name')
    unit=request.form.get('unit')
    rank=request.form.get('rank')
    user_id=session.get('user_id')
    user=database.User.objects(user_id=user_id).first()
    user.update(email=email, interest_tag=interest_tag, name= name, unit=unit, rank=rank)
    return redirect('/info')