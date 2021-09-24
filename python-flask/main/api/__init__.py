from functools import wraps
from flask import session,url_for,redirect
#로그인 확인 데코레이터
def login_require(f):
    @wraps(f)
    def func(*args,**kwargs):
        if session.get('user_id') is None:
            return redirect(url_for('sign_in'))
        return f(*args,**kwargs)
    return func