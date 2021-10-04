#book blueprint
import requests
import json
from flask import Blueprint, request
from main.models import database

unit_page=Blueprint('book',__name__)

@book_page.route('/search=<title>',methods=['GET','POST'])
def book_search():
    a = list (database.client.DevLib.book.find( {'title': { '$regex': '{0}'.format(title), '$options': 'i' }} ))
    return a[0]['title'] 
    #예외코드 안만듬, "[세트] 달러구트 꿈 백화점 1~2 - 전2권" 만 검색가능