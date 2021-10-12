#search blueprint
from flask import Blueprint, json, Response
from main.models import database

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
    resultJson = sob[0].to_json()#.get('log')
    return Response(resultJson,mimetype="application/json",status=200)

@search_page.route('/<user_id>/searchlog',methods=['GET'])
def search_log(user_id):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    resultJson = sob[0].to_json()#.get('log')
    return Response(resultJson,mimetype="application/json",status=200)

@search_page.route('/<user_id>/searchlog=10',methods=['GET', 'POST'])
def search_log_10(user_id):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        sob.save()
    if len(sob[0]['log']) <= 10:
        resultJson = sob[0].to_json()#.get('log')
        return Response(resultJson,mimetype="application/json",status=200)
    else :
        jsl = {'user_Id': '{0}'.format(user_id) , 'log': sob[0]['log'][len(sob[0]['log'])-10:len(sob[0]['log'])]}
        resultJson = json.dumps(jsl)
    return Response(resultJson,mimetype="application/json",status=200)

@search_page.route('/<user_id>/searchlog=delete',methods=['DELETE'])
def search_log_delete(user_id):
    sob = database.Searchlog.objects(user_id='{0}'.format(user_id))
    if len(sob) == 0 :
        database.Searchlog(user_id='{0}'.format(user_id)).save()
    sob[0].update(log = [])
    resultJson = sob[0].to_json()#.get('log')
    return Response(resultJson,mimetype="application/json",status=200)