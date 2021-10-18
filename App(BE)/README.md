
<div align="center">

  <h3 align="center">내 손 안의 진중문고, HandyLib</h3>
  <p align="center">
    진중문고를 내 손안으로!
    <br />
    <a href="https://www.notion.so/DevLib-0960a793aa544b2bbc3038d309ad2c47"><strong>개발 문서</strong></a>
    <br />
    <br />
    <a href="https://www.projectlib.tk">View Demo site</a>
  </p>
</div>



  <span><strong>목차</strong></span>
  <ol>
    <li><a href="#Back-End">Back-End</a></li>
    <li><a href="#Dependencies">Dependencies</a></li>
    <li><a href="#Technology_Stack">Technology Stack</a></li>
    <li><a href="#Installation">Installation</a></li>
    <li><a href="#test">Test</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#databases">DB structure</a></li>
    <li><a href="#API_Reference">API Reference</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>

## Back-End
Back-End에서는 python flask와 mongodb를 사용하여 데이터베이스를 구축하고 서버 통신이 가능하도록 REST API를 개발하였습니다.


## Dependencies
+ flask-mongoengine==1.0.0
+ Flask-WTF==0.15.1
+ Flask-Script==2.0.6
+ email-validator==1.1.3
+ fastimport==0.9.14
+ pymongo==3.12.0
+ Pillow==8.3.2
+ Werkzeug==2.0.2
+ pytest==6.2.5
+ [etc](https://www.notion.so/Dependencies-65da052287ab4b3497848508d1c87358)
<a id = "Technology_Stack"></a>

## Technology Stack
+ [python, Flask](https://flask.palletsprojects.com/en/2.0.x/)
+ [MongoDB](https://www.mongodb.com/cloud/atlas/lp/try2?utm_source=google&utm_campaign=gs_apac_south_korea_search_core_brand_atlas_desktop&utm_term=mongodb&utm_medium=cpc_paid_search&utm_ad=e&utm_ad_campaign_id=12212624365&gclid=Cj0KCQjwqp-LBhDQARIsAO0a6aJDBv9E4rs6c4Na0WH_tBu-0TSDAuFCQlRaPZCRUj4o2zFxZ1CTwHgaAvqKEALw_wcB), [mongoengine](https://flask.palletsprojects.com/en/2.0.x/patterns/mongoengine/)
+ [Microsoft Azure cloud](https://azure.microsoft.com/ko-kr/)
+ [Git](https://git-scm.com/)
+ [apache2](https://httpd.apache.org/)
+ [wsgi](https://docs.python.org/ko/3/library/wsgiref.html)
+ [cloudflare](https://www.cloudflare.com/ko-kr/)
+ [Vultr DNS](https://www.vultr.com/docs/introduction-to-vultr-dns)


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

## Test

테스트 사용법은 다음과 같습니다
* pip
  ```sh
  $ python test_.py
  ```
또는 postman을 이용해서 아래 <a href="#API_Reference">API Reference</a>를 참고해서 테스트 해보실 수 있습니다.
테스트 사이트는 https://www.projectlib.tk를 이용하시면 됩니다.

## Contributing
Follow the steps below to contribute this project.

1. Fork the Project
2. Create your Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

## License
Distributed under the MIT License. See [LICENSE.txt](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/LICENSE) for more information.

<a id = "databases"></a>

## DB structure

![DBimg](https://humdrum-anise-0dc.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F81ec89d7-0808-47ed-89b7-48c5f605f641%2F2.png?table=block&id=01de5423-ae71-42db-b4b0-0acfe2c57f2b&spaceId=838bf944-efb3-4319-ac45-238563161cf9&width=2000&userId=&cache=v2)

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
| `GET` | `제목검색 알라딘 책 json(5개)` | `title, page(Int 0≥)` |

```https
  GET /book/search/categoryId=<categoryId>&page=<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `장르별검색 알라딘 책 json(5개)` | `categoryId, page(Int 0≥)` |

```https
  GET /book/feed/categoryId=<categoryId>&page=<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `장르별검색 알라딘 책 json(5개)` | `categoryId, page(Int 0≥)` |

```https
  GET /book/search/isbn=<isbn>&page=<page>
```

| method | response     | request                |
| :-------- | :------- | :------------------------- |
| `GET` | `isbn검색 알라딘 책 json(5개)` | `isbn, page(Int 0≥)` |


<a id = "issues"></a>

## Issues
<ol>
  <li>apache 서버 재부팅시 /var/run에 있는 wsgi.socket 파일에 대한 권한을 777로 부여해야 실행되는 오류가 있습니다.</li>
</ol>

<a id = "contact"></a>

## Contact
김수민(Eeap) - kdg97811@naver.com    </br>
고명진(B-1GO) - mj2000go@naver.com    </br>
