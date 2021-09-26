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

@search_page.route('/<user_id>/search=<keyword>',methods=['POST'])
def search_keyword(user_id, keyword):
    u = []
    u = "// ".join(Searchlog.objects(user_id='{0}'.format(user_id))[0].log)
    if u == '' :
        u += '{0}'.format(keyword)
    else :
        u += '// {0}'.format(keyword)
    Searchlog.objects(user_id='{0}'.format(user_id))[0].update(log = u.split('// '))
    return "search_success" # 검색 목록 띄우기

@search_page.route('/<user_id>/searchlog',methods=['GET'])
def search_log(user_id):
    u = ""
    u = ", ".join(Searchlog.objects(user_id='{0}'.format(user_id))[0].log)
    return u
    # 예외코드 아직 안만듬

@search_page.route('/<user_id>/searchlog=delete',methods=['POST'])
def search_log_delete(user_id):
    if len(Searchlog.objects(user_id='{0}'.format(user_id))) == 0 :
        Searchlog(user_id='{0}'.format(user_id)).save()
    Searchlog.objects(user_id='{0}'.format(user_id))[0].update(log = [])
    return "delete_success" # 삭제성공 메시지 or 사라진 검색log 출력