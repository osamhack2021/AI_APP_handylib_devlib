from flask import Blueprint,request,session,Response,json
from main.models import database
import csv,os
from dotenv import load_dotenv
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote

mypage_page=Blueprint('mypage',__name__)

def read_book(query):
    # book api를 이용해서 이미지 등 읽어오기
    load_dotenv()
    client_id=os.environ.get('Client_ID')
    client_secret=os.environ.get('Client_Secret')
    request = Request('https://openapi.naver.com/v1/search/book?query='+quote(query))
    request.add_header('X-Naver-Client-Id', client_id)
    request.add_header('X-Naver-Client-Secret', client_secret)
    response = urlopen(request).read().decode('utf-8')
    result = json.loads(response)
    return result

def read_csv():
    user_id = session.get('user_id')
    file = csv.reader(open('../models/{}.csv'.format(user_id),'r'))
    lists=[]
    for row in file:
        # 각 열마다 어떤 데이터인지 읽고 dicts에 저장
        if row[2]=='title':
            continue
        books = read_book(row[2])['items']
        isbn = books[0]['isbn']
        dict_data={"title":row[2],"author":books[0]['author'],'image':books[0]['image'],'isbn':isbn[11:]}
        lists.append(dict_data)
    #dicts에 저장해서 return
    return lists

def read_borrow(borrow_list):
    borrow_lists=[]
    # book api를 이용해서 이미지 등 읽어오기
    for title in borrow_list:
        books = read_book(title)['items']
        isbn = books[0]['isbn']
        book_data={"title":title,"author":books[0]['author'],'image':books[0]['image'],'isbn':isbn[11:]}
        borrow_lists.append(book_data)
    return borrow_lists


def read_data():
    return ''



@mypage_page.route('/',methods=['GET'])
def mypage():
    if not session.get('user_id'):
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    user_id=session.get('user_id')
    #borrow_list 불러오기
    borrow_list=database.User(user_id=user_id).objects.first().borrow_list
    borrow_lists=read_borrow(borrow_list)
    # recommend_list 불러오기(csv파일을 불러올 예정)
    recommend_list=read_csv()
    #user_data 불러오기

    # res
    dicts={
        "borrow_list": borrow_lists,
        "recommend_list":recommend_list,
    }
    resultJson=json.dumps(dicts, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@mypage_page.route('/borrow_list',methods=['GET'])
def borrow():
    if not session.get('user_id'):
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    user_id=session.get('user_id')
    borrow_list=database.User(user_id=user_id).objects.first().borrow_list
    borrow_lists=read_borrow(borrow_list)
    resultJson=json.dumps(borrow_lists, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@mypage_page.route('/recommend_list',methods=['GET'])
def recommend():
    if not session.get('user_id'):
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    recommend_list=read_csv()
    resultJson=json.dumps(recommend_list, ensure_ascii=False)
    return Response(resultJson,mimetype="application/json",status=200)

@mypage_page.route('/user_data',methods=['GET'])
def user_data():
    if not session.get('user_id'):
        resultJson=json.dumps({"message": "not login"})
        return Response(resultJson,mimetype="application/json",status=401)
    return ""