from flask import Blueprint,request,Response,json
from main.models import database
from datetime import datetime
import time

comment_page=Blueprint('comment',__name__)


@comment_page.route('/<int:number>/comment_write',methods=['POST'])
def com_write(number):
    #comment db 추가
    params=request.get_json()
    user_id=request.values.get('user_id')
    tag=request.values.get('tag')
    if not user_id:
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    content=params['content']
    com_num=database.Comment.objects(tag=tag,board_number=number).count()+1
    database.Comment(tag=tag,board_number=number,user_id=user_id,content=content,comment_number=com_num,time_stamp=datetime.fromtimestamp(time.time())).save()
    #board db 해당 number에 comment 추가 
    data=database.Notice_board.objects(number=number,tag=tag).first()
    lists=data.comment_list
    lists.append(com_num)
    data.update(comment_list=lists)
    resultJson=json.dumps({"message": "write success"})
    return Response(resultJson,mimetype="application/json",status=200)

@comment_page.route('/<int:number>/<int:comment_number>/edit',methods=['PUT'])
def com_edit(number,comment_number):
    params=request.get_json()
    user_id=request.values.get('user_id')
    tag=request.values.get('tag')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            data=database.Comment.objects(user_id=user_id, comment_number=comment_number,board_number=number,tag=tag).first()
            data.update(content=params['content'])
            resultJson=json.dumps({"message": "edit success"})
            return Response(resultJson,mimetype="application/json",status=200)

    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)

@comment_page.route('/<int:number>/<int:comment_number>/delete',methods=['DELETE'])
def com_delete(number,comment_number):
    user_id=request.values.get('user_id')
    tag=request.values.get('tag')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            data=database.Comment.objects(tag=tag,board_number=number,user_id=user_id, comment_number=comment_number).first()
            board_data=database.Notice_board.objects(number=number,tag=tag).first()
            #board comment_number list에서 삭제
            lists=board_data.comment_list
            lists.remove(comment_number)
            board_data.update(comment_list=lists)
            #comment collection삭제
            data.delete()
            resultJson=json.dumps({"message": "delete success"})
            return Response(resultJson,mimetype="application/json",status=200)

    resultJson=json.dumps({"message": "not login"})
    return Response(resultJson,mimetype="application/json",status=401)