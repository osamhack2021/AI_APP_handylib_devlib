#search blueprint
from flask import Blueprint
from main.models import database
import json

search_page=Blueprint('search',__name__)

@search_page.route('/<user_id>/search=<keyword>',methods=['POST'])
def search_keyword(user_id, keyword):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    u = []
    u = "// ".join(sob[0].log)
    if u == '' :
        u += '{0}'.format(keyword)
    else :
        u += '// {0}'.format(keyword)
    sob[0].update(log = u.split('// '))
    return sob[0].to_json()

@search_page.route('/<user_id>/searchlog',methods=['GET'])
def search_log(user_id):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    return sob[0].to_json()#.get('log')

@search_page.route('/<user_id>/searchlog=10',methods=['POST'])
def search_log_10(user_id):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        sob.save()
    if len(sob[0]['log']) <= 10:
        return sob[0].to_json()
    else :
        jsl = {'user_Id': '{0}'.format(user_id) , 'log': sob[0]['log'][len(sob[0]['log'])-10:len(sob[0]['log'])]}
        jsl = json.dumps(jsl)
    return jsl

@search_page.route('/<user_id>/searchlog=delete',methods=['POST'])
def search_log_delete(user_id):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    sob[0].update(log = [])
    return sob[0].to_json()#.get('log')