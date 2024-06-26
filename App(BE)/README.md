

<div align="center">
  <a href="https://github.com/osamhack2021/AI_APP_handylib_devlib">
    <img src='https://user-images.githubusercontent.com/42088290/137695537-0f08fc63-1e5d-4f3c-80e2-966ce9e9db13.png' width ='80' height='80'/>
  </a>

  <h3 align="center">내 손 안의 진중문고, HandyLib</h3>
  <p align="center">
    진중문고를 내 손안으로!
    <br />
    <a href="https://www.notion.so/DevLib-0960a793aa544b2bbc3038d309ad2c47"><strong>개발 문서</strong></a>
    <br />
    <br />
    <a href="https://www.projectlib.tk">서버 사이트</a>
  </p>
</div>



  <div><b>목차</b></div>
  <ol>
    <li><a href="#Back-End">Back-End</a></li>
    <li><a href="#Dependencies">Dependencies</a></li>
    <li><a href="#Technology_Stack">Technology Stack</a></li>
    <li><a href="#Installation">Installation</a></li>
    <li><a href="#directory">Directory Structure</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#databases">DB structure</a></li>
    <li><a href="#API_Reference">API Reference</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>

## Back-End
Back-End에서는 python flask와 mongodb를 사용하여 데이터베이스를 구축하고 서버 통신이 가능하도록 REST API를 개발하였습니다.


## Dependencies
| flask-mongoengine | Flask-WTF | Flask-Script | email-validator |
| :-------- | :-------- | :-------- | :-------- |
| `1.0.0` | `0.15.1` | `2.0.6` | `1.1.3` |

| fastimport | pymongo | Pillow | Werkzeug | pytest |
| :-------- | :-------- | :-------- | :-------- | :-------- |
| `0.9.14` | `3.12.0` | `8.3.2` | `2.0.2` | `6.2.5` |

<br />

+ [etc](https://www.notion.so/Dependencies-65da052287ab4b3497848508d1c87358)

<a id = "Technology_Stack"></a>

## Technology Stack

### [python, Flask](https://flask.palletsprojects.com/en/2.0.x/), [pymongo](https://pypi.org/project/pymongo/)
### [MongoDB](https://www.mongodb.com/cloud/atlas/lp/try2?utm_source=google&utm_campaign=gs_apac_south_korea_search_core_brand_atlas_desktop&utm_term=mongodb&utm_medium=cpc_paid_search&utm_ad=e&utm_ad_campaign_id=12212624365&gclid=Cj0KCQjwqp-LBhDQARIsAO0a6aJDBv9E4rs6c4Na0WH_tBu-0TSDAuFCQlRaPZCRUj4o2zFxZ1CTwHgaAvqKEALw_wcB), [mongoengine](https://flask.palletsprojects.com/en/2.0.x/patterns/mongoengine/)
### [Microsoft Azure cloud](https://azure.microsoft.com/ko-kr/)
### [Git](https://git-scm.com/)
### [apache2](https://httpd.apache.org/)
### [cloudflare](https://www.cloudflare.com/ko-kr/)
### [Vultr DNS](https://www.vultr.com/docs/introduction-to-vultr-dns)


## Installation
1. Install python from [link](https://www.python.org/)
2. Clone this repository and navigate into it
  ```sh
  $ git clone https://github.com/osamhack2021/AI_APP_handylib_devlib.git
  $ cd /App(BE)
  ```
3. Install the project's dependencies
* pip
  ```sh
  $ pip install -r requirements.txt
  ```
4. start the project
  ```sh
  $ python app_start.py
  ```

<a id = "directory"></a>

## Directory Structure
```
+ APP(BE)
  + main
    + api
    + models
      + database.py
    + static
      + img
      + templates
    + app.py
  + .gitignore
  + app_start.py
  + config.py
  + README.d
  + requirements.txt

```



## License
Distributed under the MIT License. See [LICENSE.txt](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/LICENSE) for more information.

<a id = "databases"></a>

## DB structure

![DBimg](https://humdrum-anise-0dc.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fc952da56-27ae-48c3-99cf-2df7e9979704%2F2.png?table=block&id=01de5423-ae71-42db-b4b0-0acfe2c57f2b&spaceId=838bf944-efb3-4319-ac45-238563161cf9&width=2000&userId=&cache=v2)

<a id = "API_Reference"></a>

## API Reference

### 회원가입

```https
  POST /sign_up
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `POST` | `message` | `name, user_id, email, password,interest_tag,rank,unit` |

### 로그인

```https
  POST /sing_in
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `POST` | `message` | `user_id,password` |

### 마이페이지

```https
  GET /mypage?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `대출, 추천리스트,취향 데이터 json` | `user_id` |

```https
  GET /mypage/borrow_list?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `대출 list json` | `user_id` |

```https
  GET /mypage/recommend_list?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `추천 list json` | `user_id` |


### 개인정보 수정

```https
  GET /info?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `user collection json` | `user_id` |

```https
  PUT /info/edit?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `PUT` | `message` | `email,user_id,name,unit,rank,password` |

### 게시판

```https
  GET /board/<page_id>?tag=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `해당분야 페이지 게시판 10개 게시글 json` | `tag,page_id` |

```https
  GET /board/page/<page_id>?tag=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `해당 number 게시물 json` | `tag,number` |


```https
  POST /board/write?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `POST` | `message` | `content,title,tag,user_id` |


```https
  PUT /board/page/<number>/edit?user_id=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `PUT` | `message` | `content,title,tag,number,user_id` |


```https
  DELETE /board/page/<number>/delete?user_id=xxx&tag=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `DELETE` | `message` | `tag,number,user_id` |

### 댓글

```https
  POST /board/page/<number>/comment_write?user_id=xxx&tag=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `POST` | `message` | `content,number,tag,user_id` |

```https
  PUT /board/page/<number>/<comment_number>/edit?user_id=xxx&tag=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `PUT` | `message` | `content,number,comment_number,user_id,tag` |

```https
  DELETE /board/page/<number>/<comment_number>/delete?user_id=xxx&tag=xxx
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `DELETE` | `message` | `comment_number,number,user_id,tag` |


### 부대

```https
  GET /unit
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `부대 이름 json` | `-` |



```https
  GET /unit/<Unit_name>&<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `전체 Embook 리스트 json (18개씩 book json 리턴)` | `Unit_name` |

```https
  GET /unit/best/Unit_name=<Unit_name>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `Embook 리스트 json(상위 10개 book json 리턴)` | `Unit_name` |

```https
  GET /unit/new/Unit_name=<Unit_name>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `Embook 리스트 json(새로운 10개 book json 리턴)` | `Unit_name` |

```https
  GET /unit/chk/Unit_name=<Unit_name>&isbn=<isbn>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `Embook 정보 json` | `Unit_name, isbn` |

```https
  GET /unit/chk/Unit_name=<Unit_name>&user_id=<user_id>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `Embook 정보 json` | `Unit_name, user_id` |

```https
  POST /unit/brr/Unit_name=<Unit_name>&isbn=<isbn>&user_id=<user_id>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `POST` | `Embook 대여 및 정보 json` | `Unit_name, isbn,user_id` |

```https
  POST /unit/ret/Unit_name=<Unit_name>&isbn=<isbn>&user_id=<user_id>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `POST` | `Embook 반납 및 정보 json` | `Unit_name, isbn,user_id` |


### 검색기록

```https
  GET,POST /<user_id>/searchkeyword=<keyword>
```

| method | response    | request    | key  |
| :-------- | :------- | :------------- | :-----|
| `GET,POST` | `검색기록저장 json` | `user_id,keyword` | `user_id,log`|

```https
  GET,POST /<user_id>/searchlog
```

| method | response    | request    | key  |
| :-------- | :------- | :------------- | :-----|
| `GET,POST` | `전체검색기록 json` | `user_id` | `user_id,log`|

```https
  GET,POST /<user_id>/searchlog=10
```

| method | response    | request    | key  |
| :-------- | :------- | :------------- | :-----|
| `GET,POST` | `10개검색기록 json` | `user_id` | `user_id,log`|

```https
  DELETE /<user_id>/searchlog=delete
```

| method | response    | request    | key  |
| :-------- | :------- | :------------- | :-----|
| `GET,POST` | `검색기록모두삭제 json` | `user_id` | `user_id,log`|

### 좋아요

```https
  GET /like?user_id=xxx&isbn=xxx
```

| method | response     | request        |
| :-------- | :------- | :----------------------- |
| `GET` | `True or False message` | `isbn,user_id` |

```https
  POST /like?user_id=xxx&isbn=xxx
```
| method | response     | request        |
| :-------- | :------- | :----------------------- |
| `POST` | `message` | `isbn,user_id` |



### 책

```https
  GET /book/search/title=<title>&page=<page>
```

| method | response     | request        |
| :-------- | :------- | :----------------------- |
| `GET` | `제목검색 book json(5개)` | `title, page(Int 0≥)` |

```https
  GET /book/search/categoryId=<categoryId>&page=<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `장르별검색 book json(5개)` | `categoryId, page(Int 0≥)` |

```https
  GET /book/feed/categoryId=<categoryId>&page=<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `장르별검색 book json(5개)` | `categoryId, page(Int 0≥)` |

```https
  GET /book/search/isbn=<isbn>&page=<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `isbn검색 book json(5개)` | `isbn, page(Int 0≥)` |


<a id = "issues"></a>

## Issues
<ol>
  <li>apache 서버 재부팅시 /var/run에 있는 wsgi.socket 파일에 대한 권한을 777로 부여해야 실행되는 오류가 있습니다.</li>
</ol>

<a id = "contact"></a>

## Contact
김수민(Eeap) - kdg97811@naver.com    </br>
고명진(B-1GO) - mj2000go@naver.com    </br>
