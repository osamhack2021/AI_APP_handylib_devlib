from main.api import login_require
from flask import Blueprint,request,render_template
from main.models import database
board_page=Blueprint('board',__name__)

#메인 페이지 불러오는 라우터
#page_id 는 맨 아래 페이지 아이디 한 페이지에 10개의 게시판 글 띄우기
@board_page.route('/<int:page_id>',methods=['GET'])
def boarding(page_id):
    #pageid에 따라 게시판 수량 띄우기
    return ''
#해당 페이지 불러오는 라우터
@board_page.route('/<int:number>',methods=['GET'])
def board_number(page_id):
    if request.method=='GET':
        return render_template('board.html')
        
#작성 요청 라우터
@board_page.route('/write',methods=['POST'])
@login_require     
def write_board():
    return ''

#수정 요청 라우터
@board_page.route('/<int:number>/edit',methods=['PUT'])
@login_require
def edit_board():  
    return ''

#삭제 요청 라우터
@board_page.route('/<int:number>/delete',methods=['DELETE'])
@login_require
def delete_board():
    return ''