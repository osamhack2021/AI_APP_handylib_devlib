#book blueprint
from flask import Blueprint, json
from main.models import database

unit_page=Blueprint('book',__name__)

@book_page.route('/search=<title>',methods=['GET','POST'])
def book_search():
    ajson = []
    a = list (database.client.DevLib.book.find( {'title': { '$regex': '{}'.format(title), '$options': 'i' }} ))
    for o in range(len(a)):
        del(a[o]['_id'])
        ajson.append(json.dumps(a[o]))
    result = {'list': ajson }
    resultJson = json.dumps(result)
    return Response(resultJson,mimetype="application/json",status=200)