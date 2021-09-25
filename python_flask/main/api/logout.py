from flask import Blueprint, session,redirect
logout_page=Blueprint('logout',__name__)

@logout_page.route('/')
def logout():
    session.pop('user_id',None)
    return redirect('/')
        
        
