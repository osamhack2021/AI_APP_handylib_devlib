from flask import Blueprint,json,Response
logout_page=Blueprint('logout',__name__)

@logout_page.route('/')
def logout():
    resultJson=json.dumps({"message": "logout success"})
    return Response(resultJson,mimetype="application/json",status=200)
        
        
