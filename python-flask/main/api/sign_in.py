from flask import Blueprint,request,session,render_template
from main.models import database

sign_in_page=Blueprint('sign_in',__name__,url_prefix='/sign_in')

@sign_in_page.route('/',methods=['GET','POST'])
def sign_in():
    if request.method=='GET':
        return render_template('sign_in.html')
    else:
        id = request.form.get('user_id')
        pwd=request.form.get('password')
        users=database.User.objects(user_id=id).first()
        if not users:
            return render_template('sign_in.html')
        else:
            if users.password==pwd:
                session["user_id"]=id
                session["name"]=users.name
                session.permanent=True
            else:
                return render_template('sign_in.html')
    return render_template('index.html')
        
        
