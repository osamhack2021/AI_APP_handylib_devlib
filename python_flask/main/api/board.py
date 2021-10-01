from main.api import login_require
from flask import Blueprint, json,request,Response,session
from main.models import database
from datetime import datetime
import time
board_page=Blueprint('board',__name__)

#메인 페이지 불러오는 라우터
#page_id 는 맨 아래 페이지 아이디 한 페이지에 10개의 게시판 글 띄우기
@board_page.route('/<int:page_id>',methods=['GET'])
@login_require
def boarding(page_id):
    limit=10
    start=(page_id-1)*limit
    end=page_id*limit
    lists=database.Notice_board.objects(tag=request.args.get('tag'))
    if end > lists.count():
        end=lists.count()
    #pageid에 따라 게시판 수량 띄우기
    to_list = lists[start:end].to_json()
    resultJson=json.dumps(to_list, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)
#해당 페이지 불러오는 라우터
@board_page.route('/page/<int:number>',methods=['GET'])
@login_require
def board_number(number):
    board_item=database.Notice_board.objects(number=number,tag=request.args.get('tag')).first().to_json()
    resultJson=json.dumps(board_item, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)
#작성 요청 라우터
@board_page.route('/write',methods=['POST'])
@login_require     
def write_board():
    content=request.form.get('content')
    title = request.form.get('title')
    user_id=session.get('user_id')
    tag=request.form.get('tag')
    count=database.Notice_board.objects(tag=tag).count()+1
    database.Notice_board(content=content, title=title, user_id=user_id, tag=tag, time_stamp=datetime.fromtimestamp(time.time()), number=count).save()
    resultJson=json.dumps({"message": "write success"})
    return Response(resultJson,mimetype="application/json",status=200)
#수정 요청 라우터
@board_page.route('/page/<int:number>/edit',methods=['PUT'])
@login_require
def edit_board(number):  
    board_item = database.Notice_board.objects(number=number,tag=request.form.get('tag')).first()
    board_item.update(title=request.form.get('title'),content=request.form.get('content'))
    resultJson=json.dumps({"message": "edit success"})
    return Response(resultJson,mimetype="application/json",status=200)

#삭제 요청 라우터
@board_page.route('/page/<int:number>/delete',methods=['DELETE'])
@login_require
def delete_board(number):
    board_item = database.Notice_board.objects(number=number,tag=request.args.get('tag')).first()
    board_item.delete()
    resultJson=json.dumps({"message": "delete success"})
    return Response(resultJson,mimetype="application/json",status=200)