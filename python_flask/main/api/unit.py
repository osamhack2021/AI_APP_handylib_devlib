#Unit blueprint
from flask import Blueprint, request
from main.models import database

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
def Unit_books_list(Unit_name):
    if Unit_name == "1번부대" or "2번부대" :
        u = ""
        u = ", ".join(database.Unit.objects(name='{0}'.format(Unit_name))[0].books_list)
    else :
        return "올바른 부대를 입력해주세요"
    return u
