from flask import Blueprint, json,request,Response
from main.models import database
from datetime import datetime
import time
board_page=Blueprint('board',__name__)

#메인 페이지 불러오는 라우터
#page_id 는 맨 아래 페이지 아이디 한 페이지에 10개의 게시판 글 띄우기
@board_page.route('/<int:page_id>',methods=['GET'])
def boarding(page_id):
    limit=10
    start=(page_id-1)*limit
    end=page_id*limit
    lists=database.Notice_board.objects(tag=request.values.get('tag'))
    if end > lists.count():
        end=lists.count()
    #pageid에 따라 게시판 수량 띄우기
    to_list = lists[start:end]
    resultJson=json.dumps(to_list, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)
#해당 페이지 불러오는 라우터
@board_page.route('/page/<int:number>',methods=['GET'])
def board_number(number):
    board_item=database.Notice_board.objects(number=number,tag=request.values.get('tag')).first()
    comments= []
    # 댓글 내용 comment 컬렉션에서 불러오기
    for num in board_item.comment_list:
        comments.append(database.Comment.objects(user_id=board_item.user_id, comment_number=num).first().to_json)
    board_item.comment_list=comments
    resultJson=json.dumps(board_item, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)
#작성 요청 라우터
@board_page.route('/write',methods=['POST'])
def write_board():
    params=request.get_json()
    user_id=request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            content=params['content']
            title = params['title']
            tag=params['tag']
            count=database.Notice_board.objects(tag=tag).count()+1
            database.Notice_board(content=content, title=title, user_id=user_id, tag=tag, time_stamp=datetime.fromtimestamp(time.time()), number=count).save()
            resultJson=json.dumps({"message": "write success"})
            return Response(resultJson,mimetype="application/json",status=200)
    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)
    
#수정 요청 라우터
@board_page.route('/page/<int:number>/edit',methods=['PUT'])
def edit_board(number):
    params=request.get_json()
    user_id=request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            board_item = database.Notice_board.objects(number=number,tag=params['tag']).first()
            board_item.update(title=params['title'],content=params['content'])
            resultJson=json.dumps({"message": "edit success"})
            return Response(resultJson,mimetype="application/json",status=200)
    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)
   

#삭제 요청 라우터
@board_page.route('/page/<int:number>/delete',methods=['DELETE'])
def delete_board(number):
    user_id=request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            board_item = database.Notice_board.objects(number=number,tag=request.values.get('tag')).first()
            board_item.delete()
            resultJson=json.dumps({"message": "delete success"})
            return Response(resultJson,mimetype="application/json",status=200)
    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)