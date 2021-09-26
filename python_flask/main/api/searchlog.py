#search blueprint
from flask import Blueprint,request,Flask
from flask.templating import render_template
from flask_mongoengine import MongoEngine
from mongoengine.errors import ValidationError
from mongoengine.fields import StringField
from main.models import database # database_name = "DevLib" 에 들어있음
def not_empty(val):
    if not val:
        return ValidationError('error')

search_page=Blueprint('search',__name__,url_prefix='/search')

@search_page.route('=<keyword>',methods=['POST'])
def search_keyword(keyword):
    if keyword != null :
        p = []
        p = "// ".join(Searchlog.objects(user_id="tester")[0].log)
        p += '// {0}'.format(keyword)
        Searchlog.objects(user_id="tester")[0].update(log = p.split('// '))
        return "원하는 북 데이터 출력하게 할 예정"
    else :
        return "검색어를 입력해주세요"

# user_id가 검색한 내용을 호출 할 수 있게 함수를 만들기
