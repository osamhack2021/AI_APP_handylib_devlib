from main.api import login_require
from flask import Blueprint,request,session,redirect,Response,json
from main.models import database
import csv

mypage_page=Blueprint('mypage',__name__)

def read_csv():
    file = csv.reader(open('/list.csv','r'))
    for row in file:
        # 각 열마다 어떤 데이터인지 읽고 dicts에 저장
        lists=[row[0],row[1],row[2],row[3]]
    #dicts에 저장해서 return
    dicts={
        "user_id",
    }
    return dicts


@mypage_page.route('/',methods=['GET'])
@login_require
def mypage():
    user_id=session.get('user_id')
    borrow_list=database.User(user_id=user_id).objects.first().borrow_list
    # recommend_list를 가져오는 code 구현하기(csv파일을 불러올 예정)
    recommend_list=[]
    # user의 borrow_list와 추천 시스템의 recommend_list를 json형태로 보내줘야함
    dicts={
        "borrow_list": borrow_list,
        "recommend_list":recommend_list,
    }
    resultJson=json.dumps(dicts, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@mypage_page.route('/borrow_list',methods=['GET'])
@login_require
def borrow():
    return ''

@mypage_page.route('/recommend_list',methods=['GET'])
@login_require
def recommend():
    return ''