from flask import Blueprint,request,session,redirect,render_template
from main.models import database
sign_in_page=Blueprint('sign_in',__name__)

@sign_in_page.route('/',methods=['GET','POST'])
def sign_in():
    if request.method=='GET':
        return render_template('sign_in.html')
    else:
        user_id = request.form.get('user_id')
        pwd=request.form.get('password')
        users=database.User.objects(user_id=user_id).first()
        if not users:
            #response형태로 id 잘못 입력 보내기
            return redirect('/sign_in')
        else:
            if users.password==pwd:
                session["user_id"]=user_id
                session["name"]=users.name
                session.permanent=True
                return redirect('/')
            #실패시 response형태로 pwd 잘못 입력 보내기
            return redirect('/sign_in')
        
        
