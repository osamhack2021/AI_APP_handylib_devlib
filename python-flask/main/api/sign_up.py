#sign_up blueprint
from flask import Blueprint,request,Flask
from flask.templating import render_template
from flask_mongoengine import MongoEngine
from mongoengine.errors import ValidationError
from main.models import database
def not_empty(val):
    if not val:
        return ValidationError('error')

sign_up_page=Blueprint('sign_up',__name__,url_prefix='/sign_up')

@sign_up_page.route('/',methods=['GET','POST'])
def login():
    if request.method=='GET':
        #회원가입페이지 렌더링
        return render_template('sign_up.html')
    else:
        #user_id가 일치하는게 db에 있는지 확인
        user=database.User.objects(user_id=request.form['user_id']).first()
        if user:
            return render_template('sign_up.html')
        #user등록 흥미분야를 어떻게 리스트로 넘길지 생각할 필요가 있음
        database.User(
            user_id = request.form['user_id'],
            password=request.form['password'],
            name = request.form['name'],
            email = request.form['email'], 
            interest_tag = request.form['interest_tag']
        ).save()
        #db저장 작업이 끝나면 다른 페이지로 렌더링
        return render_template('sign_in.html')