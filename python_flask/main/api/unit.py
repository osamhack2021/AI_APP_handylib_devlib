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
    resultJson = json.dumps(jsl, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@unit_page.route('/<Unit_name>', methods=['POST'])
def Unit_books_list(Unit_name):
    c = 0
    for i in range(0,len(database.Unit.objects())):
        if database.Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        # resultJson = database.Unit.objects(name='{0}'.format(Unit_name))[0].to_json() *embook에 맞게 리턴수정 예정
        return Response(resultJson,mimetype="application/json",status=200)
    else :
        if c == 0 :
            jsl = {'Error': '부대가 없거나 올바른 부대를 입력해주세요.'}
            resultJson = json.dumps(jsl, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            jsl = {'Error': '동일한 부대 데이터가 2개이상 존재합니다.'}
            resultJson = json.dumps(jsl, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)

@unit_page.route('/<Unit_name>/best', methods=['GET', 'POST'])
def Unit_books_best(Unit_name):
    c = 0
    for i in range(0,len(database.Unit.objects())):
        if database.Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        # jsl = {'name': '{0}'.format(Unit_name), 'books_list': database.Unit.objects(name='{0}'.format(Unit_name))[0].books_list[0:9] } *score기반으로 best선정예정
        resultJson = json.dumps(jsl, ensure_ascii=False)
        return Response(resultJson,mimetype="application/json",status=200)
    else :
        if c == 0 :
            jsl = {'Error': '부대가 없거나 올바른 부대를 입력해주세요.'}
            resultJson = json.dumps(jsl, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            jsl = {'Error': '동일한 부대 데이터가 2개이상 존재합니다.'}
            resultJson = json.dumps(jsl, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)

#확인하는코드
for i in Unit.objects(name='test1')[0]['books_list']:
  if i['isbn'] == '8937479958':
    print(Embook(title=i['title'],isbn=i['isbn'],isbn13=i['isbn13'],state=i['state'],user_id=i['user_id'],score=i['score']).to_json())

# 대여하는 코드
for i in Unit.objects(name='test1')[0]['books_list']:
  if i['isbn'] == '8937479958':
    c = {'title': i['title'],'isbn': i['isbn'],'isbn13': i['isbn13'],'state': 1,'user_id': i['user_id'],'score': i['score'] + 1,'_cls': 'Embook'}
client.API_test.unit.update({'name':'test1'}, {'$pull': {'books_list': {'isbn':'8937479958'}}})    
client.API_test.unit.update({'name':'test1'}, {'$push': {'books_list': c}})
# user_id도 기입하게 수정해야됨

# 반납하는 코드
for i in Unit.objects(name='test1')[0]['books_list']:
  if i['isbn'] == '8937479958':
    c = {'title': i['title'],'isbn': i['isbn'],'isbn13': i['isbn13'],'state': 0,'user_id': '','score': i['score'],'_cls': 'Embook'}
client.API_test.unit.update({'name':'test1'}, {'$pull': {'books_list': {'isbn':'8937479958'}}})
client.API_test.unit.update({'name':'test1'}, {'$push': {'books_list': c}})
# 반납하는 유저가 맞는지 확인하는 방어코드 필요