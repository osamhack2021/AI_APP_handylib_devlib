#Unit blueprint
from flask import Blueprint,request,Flask
from flask.templating import render_template
from flask_mongoengine import MongoEngine
from mongoengine.errors import ValidationError
from mongoengine.fields import StringField
from main.models import database # database_name = "DevLib" 에 들어있음
def not_empty(val):
    if not val:
        return ValidationError('error')

unit_page=Blueprint('unit',__name__,url_prefix='/unit')

@unit_page.route('/',methods=['GET','POST'])
def unit_name():
    if request.method=='GET':
        u = []
        for i in range(0,len(database.Unit.objects())):
            u.append(database.Unit.objects[i].name)
        return ", ".join(u)
    else:
        return "Unit_name 클릭하면 url 및 값 넘기기"

@unit_page.route('/<Unit_name>', methods=['POST'])
def Unit_books_list(Unit_name):\
    if Unit_name == "1번부대":
        u = ""
        u = ", ".join(database.Unit.objects(name="1번부대")[0].books_list)
    elif Unit_name == "2번부대":
        u = ""
        u = ", ".join(database.Unit.objects(name="2번부대")[0].books_list)
    else :
        u="올바른 부대를 선택해주세요"
        
    #u = ""
    #u = ", ".join(database.Unit.objects(name=Unit_name)[0].books_list) Colab에서 구동 잘됨. codespace에서는 에러뜸;;
  return u
