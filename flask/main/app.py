#blueprint등록
from flask import Flask,redirect
from .api import sign_up
app=Flask(__name__)
app.register_blueprint(sign_up.sign_up_page)
@app.route('/')
def mainpage():
    return redirect("/sign_up")