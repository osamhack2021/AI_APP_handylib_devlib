from main.api import login_require
from flask import Blueprint,request,session,redirect,Response,json
from main.models import database
comment_page=Blueprint('comment',__name__)

@comment_page.route('/<comment_number>',methods=['GET'])
@login_require
def com_get(comment_number):
    data=database.Comment.objects(user_id=session['user_id'], comment_number=comment_number).first()
    content=data.content.to_json()
    resultJson=json.dumps(content)
    return Response(resultJson,mimetype="application/json",status=200)

@comment_page.route('/comment_write',methods=['POST'])
@login_require
def com_write(number):
    #comment db 추가
    user_id=session['user_id']
    content=request.form.get('content')
    com_num=database.Comment.objects().count()+1
    database.Comment(user_id=user_id,content=content,comment_number=com_num).save()
    #board db 해당 number에 comment 추가 
    data=database.Notice_board.objects(number=number,tag=request.args.get('tag')).first()
    data.update(
        comment_number=data.comment_number.append(com_num)
    )

    return redirect('/board/page/{number}')

@comment_page.route('/<comment_number>/edit',methods=['PUT'])
@login_require
def com_edit(number,comment_number):
    data=database.Comment.objects(user_id=session['user_id'], comment_number=comment_number).first()
    data.update(content=request.form.get('content'))
    return redirect('/board/page/{number}')

@comment_page.route('/<comment_number>/delete',methods=['DELETE'])
@login_require
def com_delete(number,comment_number):
    data=database.Comment.objects(user_id=session['user_id'], comment_number=comment_number).first()
    board_data=database.Notice_board.objects(number=number,tag=request.args.get('tag')).first()
    #board comment_number list에서 삭제
    lists=board_data.comment_number
    lists.remove(comment_number)
    board_data.update(comment_number=lists)
     #comment collection삭제
    data.delete()
    return redirect('/board/page/{number}')