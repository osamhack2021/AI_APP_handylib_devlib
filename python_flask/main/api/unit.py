#Unit blueprint
from flask import Blueprint, request
from main.models import database

unit_page=Blueprint('unit',__name__)

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
    c = 0
    for i in range(0,len(Unit.objects())):
        if Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        u = ""
        u = ", ".join(Unit.objects(name='{0}'.format(Unit_name))[0].books_list)
        return u
        #return Unit.objects(name='{0}'.format(Unit_name))[0].to_json()
    else :
        if c == 0 :
            return "부대가 없거나 올바른 부대를 입력해주세요"
        else :
            return "동일한 부대 데이터가 2개이상 존재합니다."

@unit_page.route('/<Unit_name>/best', methods=['GET'])
def Unit_books_best(Unit_name):
    c = 0
    for i in range(0,len(Unit.objects())):
        if Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        # u = ""
        # u = ", ".join(Unit.objects(name='{0}'.format(Unit_name))[0].books_list)
        return Unit.objects(name='{0}'.format(Unit_name))[0].books_list[0:9]
        #return Unit.objects(name='{0}'.format(Unit_name))[0].to_json()
    else :
        if c == 0 :
            return "부대가 없거나 올바른 부대를 입력해주세요"
        else :
            return "동일한 부대 데이터가 2개이상 존재합니다."