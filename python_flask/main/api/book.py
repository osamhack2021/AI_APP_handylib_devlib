#book blueprint
from flask import Blueprint, json, Response
from main.models import database

book_page=Blueprint('book',__name__)

@book_page.route('/search/title=<title>',methods=['GET','POST'])
def book_search():
    ajson = []
    a = list (database.client.API_test.book.find( {'title': { '$regex': '{}'.format(title) }} ))
    for o in range(len(a)):
        del(a[o]['_id'])
        ajson.append(json.dumps(a[o]))
    result = {'list': ajson }
    resultJson = json.dumps(result, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@book_page.route('/search/categoryId=<categoryId>&page=<page>',methods=['GET','POST'])
def book_search_categoryId(categoryId, page):
    categoryId = int(categoryId)
    page = int(page)
    ajson = []
    if page <= 1:
        page = 0
    else:
        page = page - 1
    a = list (database.client.API_test.book.find( {'categoryId': categoryId} ).skip(page*5).limit(5))
    for o in range(len(a)):
        del(a[o]['_id'])
        ajson.append((a[o]))
    result = {'list': ajson }
    resultJson = json.dumps(result, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@book_page.route('/feed/category/cat=<categoryId>&page=<page>',methods=['GET','POST'])
def book_search_feed_categoryId(categoryId, page):
    categoryId = int(categoryId)
    page = int(page)
    ajson = []
    if page <= 1:
        page = 0
    else:
        page = page - 1
    a = list (database.client.API_test.book.find( {'categoryId': categoryId} ).skip(page*5).limit(5))
    for o in range(len(a)):
        del(a[o]['_id'])
        ajson.append((a[o]))
    result = {'list': ajson }
    resultJson = json.dumps(result, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@book_page.route('/search/isbn=<isbn>&page=<page>',methods=['GET','POST'])
def book_search_isbn(isbn, page):
    page = int(page)
    ajson = []
    if page <= 1:
        page = 0
    else:
        page = page - 1
    a = list (database.client.API_test.book.find( {'isbn': '{}'.format(isbn)} ).skip(page*5).limit(5))
    for o in range(len(a)):
        del(a[o]['_id'])
        ajson.append((a[o]))
    result = {'list': ajson }
    resultJson = json.dumps(result, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)