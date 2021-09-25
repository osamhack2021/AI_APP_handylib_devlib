#sign_up blueprint
from flask import Blueprint, request,redirect,render_template
from main.models import database

sign_up_page = Blueprint('sign_up', __name__)


@sign_up_page.route('/', methods=['GET', 'POST'])
def sign_up():
    if request.method == 'GET':
        #회원가입페이지 렌더링
        return render_template('sign_up.html')
    else:
        #user_id가 일치하는게 db에 있는지 확인
        user = database.User.objects(user_id=request.form['user_id']).first()
        if user:
            return redirect('/sign_up')
        database.User(
            user_id=request.form['user_id'],
            password=request.form['password'],
            name=request.form['name'],
            email=request.form['email'],
            interest_tag=list(request.form['interest_tag'])
        ).save()
        
    #db저장 작업이 끝나면 다른 페이지로 렌더링
    return redirect('/sign_in')
