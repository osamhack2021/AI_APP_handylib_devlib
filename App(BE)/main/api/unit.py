#Unit blueprint
from flask import Blueprint, json, Response
from main.models import database

unit_page=Blueprint('unit',__name__)

@unit_page.route('/',methods=['GET'])
def unit_name():
    jsl = {'Unit_name': database.client.API_test.unittest.distinct('name') }
    resultJson = json.dumps(jsl, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@unit_page.route('/<Unit_name>&<page>', methods=['GET'])
def Unit_books_list(Unit_name, page):
    page = int(page)
    if page <= 1:
        page = 0
    else :
        page = page - 1
    c = 0
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'name': '{}'.format(Unit_name)}).skip(page*18).limit(18))
        for i in range(0,len(a)):
            a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
            del (a[i]['_id'])
        result = {'name': '{}'.format(Unit_name), 'books_list': a}
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
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'name': '{}'.format(Unit_name)}).sort('score',-1).limit(10))
        for i in range(0,len(a)):
            a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
            del (a[i]['_id'])
        result = {'name': '{}'.format(Unit_name), 'books_list': a}
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

@unit_page.route('/new/Unit_name=<Unit_name>', methods=['GET'])
def Unit_books_new(Unit_name):
    c = 0
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'name': '{}'.format(Unit_name)}).sort('score',1).limit(10))
        for i in range(0,len(a)):
            a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
            del (a[i]['_id'])
        result = {'name': '{}'.format(Unit_name), 'books_list': a}
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

@unit_page.route('/chk/Unit_name=<Unit_name>&isbn=<isbn>', methods=['GET'])
def Unit_books_list_chk_isbn(Unit_name, isbn):
    c = 0
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'$and':[{'name': '{}'.format(Unit_name)},{'isbn': '{}'.format(isbn)}]}))
        for i in range(0,len(a)):
            a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
            del (a[i]['_id'])
        if a == []:
            result = {'Error': 'isbn를 다시 한번 확인해주세요.'}
            resultJson = json.dumps(result, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            result = {'name': '{}'.format(Unit_name), 'books_list': a}
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

@unit_page.route('/chk/Unit_name=<Unit_name>&user_id=<user_id>', methods=['GET'])
def Unit_books_list_chk_user_id(Unit_name, user_id):
    c = 0
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'$and':[{'name': '{}'.format(Unit_name)},{'user_id': '{}'.format(user_id)}]}))
        for i in range(0,len(a)):
            a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
            del (a[i]['_id'])
        if a == []:
            result = {'Error': '해당 사용자는 대여중인 도서가 없습니다. 또는 user_id를 다시 한번 확인해주세요.'}
            resultJson = json.dumps(result, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            result = {'name': '{}'.format(Unit_name), 'books_list': a}
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

@unit_page.route('/brr/Unit_name=<Unit_name>&isbn=<isbn>&user_id=<user_id>', methods=['POST'])
def Unit_books_list_brr(Unit_name, isbn, user_id):
    c = 0
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'$and':[{'name': '{}'.format(Unit_name)},{'isbn': '{}'.format(isbn)}]}))
        for i in range(0,len(a)):
            if a[i]['isbn'] == '{}'.format(isbn):
                if a[i]['state'] == 0:
                    a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
                    del (a[i]['_id'])
                    database.Unittest.objects(name='{}'.format(Unit_name),isbn='{}'.format(isbn))[0].update(score=a[i]['score']+1,state=1,user_id='{}'.format(user_id))
                    break
                else :
                    result = {'Error': '대여된 책입니다.'}
                    resultJson = json.dumps(result, ensure_ascii=False)
                    return Response(resultJson,mimetype="application/json",status=201)
        if a == []:
            result = {'Error': 'isbn, user_id를 다시 한번 확인해주세요.'}
            resultJson = json.dumps(result, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            a = list (database.client.API_test.unittest.find({'$and':[{'name': '{}'.format(Unit_name)},{'isbn': '{}'.format(isbn)}]}))
            for i in range(0,len(a)):
                a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
                del (a[i]['_id'])
        result = {'name': '{}'.format(Unit_name), 'books_list': a}
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


@unit_page.route('/ret/Unit_name=<Unit_name>&isbn=<isbn>&user_id=<user_id>', methods=['POST'])
def Unit_books_list_ret(Unit_name, isbn, user_id):
    c = 0
    for i in database.client.API_test.unittest.distinct('name'):
        if i == '{}'.format(Unit_name):
            c += 1
    if c == 1 :
        a = list (database.client.API_test.unittest.find({'$and':[{'name': '{}'.format(Unit_name)},{'isbn': '{}'.format(isbn)}]}))
        for i in range(0,len(a)):
            if a[i]['isbn'] == '{}'.format(isbn):
                if a[i]['state'] == 1:
                    a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
                    del (a[i]['_id'])
                    database.Unittest.objects(name='{}'.format(Unit_name),isbn='{}'.format(isbn))[0].update(state=0,user_id='')
                    break
                else :
                    result = {'Error': '반납된 책입니다.'}
                    resultJson = json.dumps(result, ensure_ascii=False)
                    return Response(resultJson,mimetype="application/json",status=201)
        if a == []:
            result = {'Error': 'Unit_name, isbn, user_id를 다시 한번 확인해주세요.'}
            resultJson = json.dumps(result, ensure_ascii=False)
            return Response(resultJson,mimetype="application/json",status=201)
        else :
            a = list (database.client.API_test.unittest.find({'$and':[{'name': '{}'.format(Unit_name)},{'isbn': '{}'.format(isbn)}]}))
            for i in range(0,len(a)):
                a[i].update(database.client.API_test.book.find({'isbn': a[i]['isbn']})[0])
                del (a[i]['_id'])
        result = {'name': '{}'.format(Unit_name), 'books_list': a}
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