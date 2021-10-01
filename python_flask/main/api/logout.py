from main.api import login_require
from flask import Blueprint, session,json,Response
logout_page=Blueprint('logout',__name__)

@logout_page.route('/')
@login_require
def logout():
    session.pop('user_id',None)
    resultJson=json.dumps({"message": "logout success"})
    return Response(resultJson,mimetype="application/json",status=200)
        
        
