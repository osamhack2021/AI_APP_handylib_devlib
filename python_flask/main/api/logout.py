from main.api import login_require
from flask import Blueprint, session,redirect
from main.api import login_require
logout_page=Blueprint('logout',__name__)

@logout_page.route('/')
@login_require
def logout():
    session.pop('user_id',None)
    return redirect('/')
        
        
