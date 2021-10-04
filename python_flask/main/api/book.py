#book blueprint
import requests
import json
from flask import Blueprint, request
from main.models import database

unit_page=Blueprint('book',__name__)

@book_page.route('/search=<title>',methods=['GET','POST'])
def book_search():
    ajson = []
    a = list (client.DevLib.book.find( {'title': { '$regex': '{}'.format(title), '$options': 'i' }} ))
    for o in range(len(a)):
        del(a[o]['_id'])
        ajson.append(json.dumps(a[o]))
    return ajson[0]
    #예외코드 안만듬, "[세트] 달러구트 꿈 백화점 1~2 - 전2권" 만 검색가능