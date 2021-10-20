from flask import Blueprint,json,Response
from main.recommendation import update
logout_page=Blueprint('logout',__name__)

@logout_page.route('/')
def logout():
    resultJson=json.dumps({"message": "logout success"})
    # 서버 추천 코드
    update.update()
    return Response(resultJson,mimetype="application/json",status=200)
        
        
