from flask import Blueprint,request
from flask.templating import render_template
from main.models.database import *
login_page=Blueprint('login',__name__,url_prefix='/login')

@login_page.route('/',methods=['GET','POST'])
def login():
    if request.method=='GET':
        return render_template('login.html')
    else:
        id = request.form['user_id']
        pwd=request.form['password']
        
        
