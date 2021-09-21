#시작 페이지
from flask import Flask,redirect
from .api import sign_up

def create_app():
    app = Flask(__name__)
    app.register_blueprint(sign_up.sign_up_page, url_prefix='/sign_up')
    app.debug = True

    @app.route('/')
    def mainpage():
        return redirect("/sign_up")
    return app
