#Unit blueprint
from flask import Blueprint, json, Response
from main.models import database

unit_page=Blueprint('unit',__name__)

@unit_page.route('/',methods=['GET','POST'])
def unit_name():
    u = []
    for i in range(0,len(database.Unit.objects())):
        u.append(database.Unit.objects[i].name)
    jsl = {'Unit_names': u }
    resultJson = json.dumps(jsl)
    return Response(resultJson,mimetype="application/json",status=200)

@unit_page.route('/<Unit_name>', methods=['POST'])
def Unit_books_list(Unit_name):
    c = 0
    for i in range(0,len(database.Unit.objects())):
        if database.Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        resultJson = database.Unit.objects(name='{0}'.format(Unit_name))[0].to_json()
        return Response(resultJson,mimetype="application/json",status=200)
    else :
        if c == 0 :
            jsl = {'Error': '부대가 없거나 올바른 부대를 입력해주세요.'}
            resultJson = json.dumps(jsl)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            jsl = {'Error': '동일한 부대 데이터가 2개이상 존재합니다.'}
            resultJson = json.dumps(jsl)
            return Response(resultJson,mimetype="application/json",status=201)

@unit_page.route('/<Unit_name>/best', methods=['GET', 'POST'])
def Unit_books_best(Unit_name):
    c = 0
    for i in range(0,len(database.Unit.objects())):
        if database.Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        jsl = {'name': '{0}'.format(Unit_name), 'books_list': database.Unit.objects(name='{0}'.format(Unit_name))[0].books_list[0:9] }
        resultJson = json.dumps(jsl)
        return Response(resultJson,mimetype="application/json",status=200)
    else :
        if c == 0 :
            jsl = {'Error': '부대가 없거나 올바른 부대를 입력해주세요.'}
            resultJson = json.dumps(jsl)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            jsl = {'Error': '동일한 부대 데이터가 2개이상 존재합니다.'}
            resultJson = json.dumps(jsl)
            return Response(resultJson,mimetype="application/json",status=201)