#시작 페이지
from flask import Flask, redirect,render_template
from main.api import sign_up,sign_in,logout,board,unit,comment,account_info,searchlog
app = Flask(__name__)
app.register_blueprint(sign_up.sign_up_page,url_prefix='/sign_up')
app.register_blueprint(sign_in.sign_in_page,url_prefix='/sign_in')
app.register_blueprint(logout.logout_page,url_prefix='/logout')
app.register_blueprint(board.board_page,url_prefix='/board')
app.register_blueprint(unit.unit_page,url_prefix='/unit')
app.register_blueprint(comment.comment_page,url_prefix='/board/page')
app.register_blueprint(account_info.info_page,url_prefix='/info')
app.register_blueprint(mypage.mypage_page,url_prefix='/mypage')
app.register_blueprint(searchlog.info_page,url_prefix='/searclog')
app.debug = True


@app.route('/')
def mainpage():
    return render_template('index.html')
