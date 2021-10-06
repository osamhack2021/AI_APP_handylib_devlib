#search blueprint
from flask import Blueprint
from main.models import database

search_page=Blueprint('search',__name__)

@search_page.route('/<user_id>/search=<keyword>',methods=['POST'])
def search_keyword(user_id, keyword):
    if len(database.Searchlog.objects(user_id='{0}'.format(user_id))) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    u = []
    u = "// ".join(database.Searchlog.objects(user_id='{0}'.format(user_id))[0].log)
    if u == '' :
        u += '{0}'.format(keyword)
    else :
        u += '// {0}'.format(keyword)
    database.Searchlog.objects(user_id='{0}'.format(user_id))[0].update(log = u.split('// '))
    return "search_success" # 검색 목록 띄우기

@search_page.route('/<user_id>/searchlog',methods=['GET'])
def search_log(user_id):
    if len(database.Searchlog.objects(user_id='{0}'.format(user_id))) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    u = ""
    u = ", ".join(database.Searchlog.objects(user_id='{0}'.format(user_id))[0].log)
    return u

@search_page.route('/<user_id>/searchlog=delete',methods=['POST'])
def search_log_delete(user_id):
    if len(database.Searchlog.objects(user_id='{0}'.format(user_id))) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    database.Searchlog.objects(user_id='{0}'.format(user_id))[0].update(log = [])
    return "delete_success" # 삭제성공 메시지 or 사라진 검색log 출력