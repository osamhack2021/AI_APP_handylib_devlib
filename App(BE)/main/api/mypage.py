from flask import Blueprint, request, Response, json
from main.models import database
import csv

mypage_page = Blueprint('mypage', __name__)

def read_csv(user_id):
    file = csv.reader(open('../main/recommendation/recommend_list/{}.csv'.format(user_id), 'r',encoding='utf-8'))
    lists = []
    for row in file:
        # 각 열마다 어떤 데이터인지 읽고 dicts에 저장
        if row[2] == 'title':
            continue
        lists.append(database.Book.objects(isbn=row[1]))
    return lists

def read_borrow(borrow_list):
    borrow_lists = []
    # book api를 이용해서 이미지 등 읽어오기
    for embook in borrow_list:
        borrow_lists.append(database.Book.objects(isbn=embook['isbn']).first())
    return borrow_lists

@mypage_page.route('/', methods=['GET'])
def mypage():
    user_id = request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            # borrow_list 불러오기
            borrow_list = []
            for embook in database.Unit.objects(name=user.unit).first().books_list:
                if embook['user_id']==user_id:
                    borrow_list.append(embook)

            borrow_lists = read_borrow(borrow_list)
            # recommend_list 불러오기(csv파일을 불러올 예정)
            recommend_list = read_csv(user_id)
            # user_data 불러오기
            user_data='https://www.projectlib.tk/image/{}.png'.format(user_id)
            # res
            dicts = {
                "borrow_list": borrow_lists,
                "recommend_list": recommend_list,
                "user_data":user_data
            }
            resultJson = json.dumps(dicts, ensure_ascii=False)
            return Response(resultJson, mimetype="application/json", status=200)
    resultJson = json.dumps({"message": "not login"})
    return Response(resultJson, mimetype="application/json", status=401)

@mypage_page.route('/borrow_list', methods=['GET'])
def borrow():
    user_id = request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            borrow_list = []
            for embook in database.Unit.objects(name=user.unit).first().books_list:
                if embook['user_id']==user_id:
                    borrow_list.append(embook)
            borrow_lists = read_borrow(borrow_list)
            resultJson = json.dumps(borrow_lists, ensure_ascii=False)
            return Response(resultJson, mimetype="application/json", status=200)
    resultJson = json.dumps({"message": "not login"})
    return Response(resultJson, mimetype="application/json", status=401)

@mypage_page.route('/recommend_list', methods=['GET'])
def recommend():
    user_id = request.values.get('user_id')
    if user_id:
        user = database.User.objects(user_id=user_id).first()
        if user:
            recommend_list = read_csv(user_id)
            resultJson = json.dumps(recommend_list, ensure_ascii=False)
            return Response(resultJson, mimetype="application/json", status=200)
    resultJson = json.dumps({"message": "not login"})
    return Response(resultJson, mimetype="application/json", status=401)