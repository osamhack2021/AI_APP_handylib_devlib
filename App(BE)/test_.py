import pytest
from config import app
import json

def test_all():
    api = app.test_client()
    new_user={
        "name": 'test',
    "email": 'test@test.com',
    "password": 'test12',
    "user_id": 'test',
    "like": [],
    "rank":'일병',
    "unit":'1unit',
    }
    #sign_up
    resp=api.post('https://www.projectlib.tk/sign_up',
    data=json.dumps(new_user),
    content_type='application/json'
    )
    assert resp.status_code==200
    resp_json = json.loads(resp.data.decode('utf-8'))
    print(resp_json)
    #sign_in
    resp=api.post('https://www.projectlib.tk/sign_in',
    data=json.dumps({'user_id':new_user['user_id'],'password':new_user['password']}),
    content_type='application/json'
    )
    assert resp.status_code==200
    resp_json = json.loads(resp.data.decode('utf-8'))
    print(resp_json)
    #mypage
    resp=api.get('https://www.projectlib.tk/mypage?user_id={}'.format(new_user['user_id']),
    data=None,
    content_type='application/json'
    )
    assert resp.status_code==200
    resp_json = json.loads(resp.data.decode('utf-8'))
    print(resp_json)
    #info
    resp=api.get('https://www.projectlib.tk/info?user_id={}'.format(new_user['user_id']),
    data=None,
    content_type='application/json'
    )
    assert resp.status_code==200
    resp_json = json.loads(resp.data.decode('utf-8'))
    print(resp_json)
    #board
    resp=api.get('https://www.projectlib.tk/board/1?tag=free',
    data=None,
    content_type='application/json'
    )
    assert resp.status_code==200
    resp_json = json.loads(resp.data.decode('utf-8'))
    print(resp_json)
    return