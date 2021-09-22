#시작 페이지
from flask import Flask, redirect
from flask.templating import render_template
from main.api import sign_up
from main.api import sign_in
app = Flask(__name__)
app.register_blueprint(sign_up.sign_up_page)
app.register_blueprint(sign_in.sign_in_page)
app.debug = True


@app.route('/')
def mainpage():
    return render_template('index.html')
