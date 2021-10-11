from flask import Blueprint,request,Response,json
from main.models import database
comment_page=Blueprint('comment',__name__)

@comment_page.route('/<int:number>/<int:comment_number>',methods=['GET'])
def com_get(comment_number):
    user_id=request.args.get('user_id')
    data=database.Comment.objects(user_id=user_id, comment_number=comment_number).first()
    resultJson=json.dumps(data.content, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@comment_page.route('/<int:number>/comment_write',methods=['POST'])
def com_write(number):
    #comment db 추가
    params=request.get_json()
    user_id=request.args.get('user_id')
    if not user_id:
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    content=params['content']
    com_num=database.Comment.objects().count()+1
    database.Comment(user_id=user_id,content=content,comment_number=com_num).save()
    #board db 해당 number에 comment 추가 
    data=database.Notice_board.objects(number=number,tag=request.args.get('tag')).first()
    lists=data.comment_list
    lists.append(com_num)
    data.update(comment_list=lists)
    resultJson=json.dumps({"message": "write success"})
    return Response(resultJson,mimetype="application/json",status=200)

@comment_page.route('/<int:number>/<int:comment_number>/edit',methods=['PUT'])
def com_edit(number,comment_number):
    params=request.get_json()
    user_id=request.args.get('user_id')
    if not user_id:
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    data=database.Comment.objects(user_id=user_id, comment_number=comment_number).first()
    data.update(content=params['content'])
    resultJson=json.dumps({"message": "edit success"})
    return Response(resultJson,mimetype="application/json",status=200)

@comment_page.route('/<int:number>/<int:comment_number>/delete',methods=['DELETE'])
def com_delete(number,comment_number):
    user_id=request.args.get('user_id')
    if not user_id:
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    data=database.Comment.objects(user_id=user_id, comment_number=comment_number).first()
    board_data=database.Notice_board.objects(number=number,tag=request.args.get('tag')).first()
    #board comment_number list에서 삭제
    lists=board_data.comment_list
    lists.remove(comment_number)
    board_data.update(comment_list=lists)
     #comment collection삭제
    data.delete()
    resultJson=json.dumps({"message": "delete success"})
    return Response(resultJson,mimetype="application/json",status=200)