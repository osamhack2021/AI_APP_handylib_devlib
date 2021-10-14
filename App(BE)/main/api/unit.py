#Unit blueprint
from flask import Blueprint, json, Response
from main.models import database

unit_page=Blueprint('unit',__name__)

@unit_page.route('/',methods=['GET'])
def unit_name():
    u = []
    for i in range(0,len(database.Unit.objects())):
        u.append(database.Unit.objects[i].name)
    jsl = {'Unit_name': u }
    resultJson = json.dumps(jsl, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@unit_page.route('/<Unit_name>&<page>', methods=['GET'])
def Unit_books_list(Unit_name, page):
    page = int(page)
    c = 0
    if page <= 1:
        page = 0
    else:
        page = page - 1
    for i in range(0,len(database.Unit.objects())):
        if database.Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        q = []
        for i in database.Unit.objects(name='{}'.format(Unit_name))[0]['books_list'][page*5:(page+1)*5]:
            a = list (database.client.API_test.book.find({'isbn': i['isbn']}))
        for o in range(len(a)):
            del(a[o]['_id'])
            q.append(a[o])
        result = {'name': '{}'.format(Unit_name), 'books_list': q}
        resultJson = json.dumps(result, ensure_ascii=False)
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

@unit_page.route('/best/Unit_name=<Unit_name>', methods=['GET'])
def Unit_books_best(Unit_name):
    c = 0
    for i in range(0,len(database.Unit.objects())):
        if database.Unit.objects[i].name == '{0}'.format(Unit_name):
            c += 1
    if c == 1 :
        q = []
        for i in database.Unit.objects(name='{}'.format(Unit_name))[0]['books_list']:
            q.append(i.to_json())
        jsl = sorted(q, key=(lambda x: x['score']) , reverse=True)
        q = []
        for i in jsl[0:10]:
            q.append(database.Book.objects(isbn=i['isbn'])[0].to_json())
        jsl = {'name': '{}'.format(Unit_name), 'books_list': q}
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

@unit_page.route('/chk/Unit_name=<Unit_name>&isbn=<isbn>', methods=['GET'])
def Unit_books_list_chk(Unit_name, isbn):
    c = []
    for i in database.Unit.objects(name='{}'.format(Unit_name))[0]['books_list']:
        if i['isbn'] == '{}'.format(isbn):
            c = {'title': i['title'],'isbn': i['isbn'],'isbn13': i['isbn13'],'state': i['state'],'user_id': i['user_id'],'score': i['score'],'_cls': 'Embook'}
    if c == []:
        result = {'Error': 'Unit_name, isbn를 다시 한번 확인해주세요.'}
        resultJson = json.dumps(result, ensure_ascii=False)
        return Response(resultJson,mimetype="application/json",status=201)
    else :
        resultJson = json.dumps(c, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@unit_page.route('/brr/Unit_name=<Unit_name>&isbn=<isbn>&user_id=<user_id>', methods=['POST'])
def Unit_books_list_brr(Unit_name, isbn, user_id):
    c = []
    for i in database.Unit.objects(name='{}'.format(Unit_name))[0]['books_list']:
        if i['isbn'] == '{}'.format(isbn):
            if i['state'] == 0:
                c = {'title': i['title'],'isbn': i['isbn'],'isbn13': i['isbn13'],'state': 1,'user_id': '{}'.format(user_id),'score': i['score'] + 1,'_cls': 'Embook'}
            else :
                result = {'Error': '대여된 책입니다.'}
                resultJson = json.dumps(result, ensure_ascii=False)
                return Response(resultJson,mimetype="application/json",status=201)
    if c == []:
        result = {'Error': 'Unit_name, isbn, user_id를 다시 한번 확인해주세요.'}
        resultJson = json.dumps(result, ensure_ascii=False)
        return Response(resultJson,mimetype="application/json",status=201)
    else :
        database.client.API_test.unit.update({'name':'{}'.format(Unit_name)}, {'$pull': {'books_list': {'isbn':'{}'.format(isbn)}}})
        database.client.API_test.unit.update({'name':'{}'.format(Unit_name)}, {'$push': {'books_list': c}})
    resultJson = json.dumps(c, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@unit_page.route('/ret/Unit_name=<Unit_name>&isbn=<isbn>&user_id=<user_id>', methods=['POST'])
def Unit_books_list_ret(Unit_name, isbn, user_id):
    c = []
    for i in database.Unit.objects(name='{}'.format(Unit_name))[0]['books_list']:
        if i['isbn'] == '{}'.format(isbn):
            if i['user_id'] == '{}'.format(user_id):
                if i['state'] == 1:
                    c = {'title': i['title'],'isbn': i['isbn'],'isbn13': i['isbn13'],'state': 0,'user_id': '','score': i['score'],'_cls': 'Embook'}
                else :
                    result = {'Error': '반납된 책입니다.'}
                    resultJson = json.dumps(result, ensure_ascii=False)
                    return Response(resultJson,mimetype="application/json",status=201)
    if c == []:
        result = {'Error': 'Unit_name, isbn, user_id를 다시 한번 확인해주세요.'}
        resultJson = json.dumps(result, ensure_ascii=False)
        return Response(resultJson,mimetype="application/json",status=201)
    else :
        database.client.API_test.unit.update({'name':'{}'.format(Unit_name)}, {'$pull': {'books_list': {'isbn':'{}'.format(isbn)}}})
        database.client.API_test.unit.update({'name':'{}'.format(Unit_name)}, {'$push': {'books_list': c}})
    resultJson = json.dumps(c, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)