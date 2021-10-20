<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="https://user-images.githubusercontent.com/19871043/137923020-43a87404-7754-4c22-83e7-1b428da35ef7.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">내 손 안의 진중문고, HandyLib</h3>

  <p align="center">
    진중문고를 내 손안으로!
    <br />
    <a href="https://humdrum-anise-0dc.notion.site/DevLib-0960a793aa544b2bbc3038d309ad2c47"><strong>[ 개발문서 보기 ]</strong></a>
    <a href="https://hyejin-degreeshow.site/"><strong>[ Demo 보기 ]</strong></a>
  </p>
</div>

<span>Readme 목차</span>
  <ol>
    <li>
      AI (recommendation)
    </li>
    <li>
      책 추천시스템
    </li>
    <li>
      취향정보 시각화
    </li>
    <li>
      시작하기
      <ul>
        <li>요구사항</li>
        <li>설치</li>
        <li>설정</li>
        <li>사용법</li>
      </ul>
    </li>
    <li>발전방향</li>
    <li>라이센스</li>
    <li>개발자 정보</li>
  </ol>

<!-- ABOUT THE PROJECT -->



# 1. AI (recommendation)
AI에서는 개인별 책 추천시스템과 사용자의 취향정보 시각화를 담당하였습니다.

추천시스템 개발과정과 보다 자세한 설명을 원하신다면 링크에서 AI 파트의 개발문서를 확인해주시기 바랍니다.
[AI [recommender system]](https://www.notion.so/AI-Recommendation-e97a10b6db184d2aabb2f67b3eac3b85)

# 2. 책 추천시스템
서버에서 사용자 및 책 정보를 요청하여, Matrix Factorization 기반 추천 리스트 30권을 생성합니다.

![img_AI_pick.png](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/image_ai/AI%EC%9D%98%20PICK.PNG)

[API_test_users.csv](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/example_file/API_test_users.csv) : userid_0의 like는 [1247, 164, 89, 1219, 903]입니다.

+ 1247 : 국내도서>수험서/자격증>공무원 수험서>소방공무원(승진)>기타 과목
+ 164 : 국내도서>사회과학>국방/군사학>국내외 군사사정
+ 89 : 국내도서>자기계발>성공>성공담
+ 1219 : 국내도서>자기계발>성공>성공담
+ 국내도서>전집/중고전집>창작동화

![img_1.png](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/image_ai/img_1.png)

[userid_0.csv <todo : add csv and make link>]에 나온 추천도서는 [1030, 1413, 626, 1150, 167] 등 30권입니다.

+ 1030 : 조선왕조실톡 6 - 조선의 두 번째 영광 (국내도서>역사>조선사>조선후기(영조~순종))
+ 1413 : 삶의 덫에서 벗어나 새로운 나를 열기 (국내도서>자기계발>힐링>마음 다스리기))
+ 626 : 숲, 다시 보기를 권함 (국내도서>과학>생명과학>생태학)
+ 1150 : 회사에서 나만 그래? - 언니들이 알려주는 조직생활 노하우 26 (국내도서>자기계발>여성의 자기계발)
+ 167 : 우린 다르게 살기로 했다 - 혼자는 외롭고 함께는 괴로운 사람들을 위한 마을공동체 탐사기 (국내도서>사회과학>사회운동>사회운동 일반)

![img.png](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/image_ai/img.png)

# 3. 취향정보 시각화
사용자가 좋아요를 누른 책을 기반으로 사용자가 좋아하는 카테고리를 wordcloud로 시각화합니다.

![img_3.png](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/image_ai/img_3.png)

# 4. 시작하기
## 요구사항
- wordcloud==1.8.1
- pandas==1.3.3
- numpy>=1.19.5

다음 코드를 실행하여 필요한 모듈을 설치합니다. 
```buildoutcfg
$ pip install pandas
$ pip install numpy
$ pip install wordcloud
```

## 설치
backend에서 구성한 환경에서 /var/www/main/ 경로에 다음과 같이 파일을 생성합니다.
추천리스트와 이미지가 저장되는 이해를 돕고자 (괄호)로 예시를 들어 설명하였습니다.

recommendation 경로는 github 상에서 AI 경로에 해당합니다.

/main/api/ 경로에는 BE에서 api를 구현한 파일이 있으며, 추천시스템과 취향정보 이미지가 필요할 때 /main/recommendation/에서 필요한 모듈을 호출하여 사용합니다.
  
### Directory
+ main
  + recommendation
    + ALS.py
    + recommend_list
      + (admin.csv)
      + (abcd.csv)
    + APP_test_books.csv
    + APP_test_users.csv
    + rec_pred_score_1.csv
    + dummy_generator.py
    + dummy_user.py
    + recommendation.py
    + update.py
    + data_update.py
    + wordcloud_maker.py
  + api
  + static
    + img
      + (admin.png)
      + (abcd.png)

## 설정
개발 환경에 맞추어 경로, 파일명 변수를 변경해주셔야 합니다.

개발환경에 맞추어 수정해야 하는 부분은 ```# 환경에 맞게 수정``` 이라는 주석으로 표기하였습니다. 아래 예시를 참고해주시기 바랍니다.
주석에 있는 예시는 서버와 연동하기 전, C드라이브에서 작업했던 환경입니다.
```buildoutcfg
# wordcloud_maker.py 일부..
def exe_img(user_id):
    file_path = '/var/www/python_flask/main/recommendation/'    # 환경에 맞게 file_path 수정. ex) file_path = 'C:/Users/admin/Documents/handylib/'
    save_path = '/var/www/python_flask/main/static/img/'        # 환경에 맞게 save_path 수정. ex) save_path = 'C:/Users/admin/Documents/handylib/img/'
    users_file_name = "API_test_users.csv"                      # 환경에 맞게 file_name 수정. ex) users_file_name = '1unit_users.csv'
    books_file_name = "API_test_books.csv"                      # 환경에 맞게 file_name 수정. ex) books_file_name = '2unit_books.csv'
    font_path = "/var/www/python_flask/main/recommendation/NanumFontSetup_TTF_BARUNPEN/NanumBarunpenR.ttf"  # 환경에 맞게 path 수정. ex) font_path = 'C:/Users/admin/Documents/handylib/NanumBarunpenR.ttf'
    make_wordcloud(file_path, save_path, font_path, users_file_name, books_file_name, user_id)
```

file_path는 recommendation에 해당하는 경로를 의미합니다.
책, 사용자 정보를 담은 파일, 추천리스트와 취향분석 이미지를 생성하는 코드가 저장된 경로를 적어주시면 됩니다.
```buildoutcfg
# 개인 PC에서 실행할 경우
file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'

# 서버 venv에서 실행할 경우 
file_path = '/var/www/python_flask/recommendation/'
```
users_file_name과 books_file_name은 사용자 정보와 책 정보가 담긴 .csv 형식 파일의 이름을 적어주시면 됩니다.
<a href="https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/example_file">example_file</a>의 API_test_users와 API_test_books를 참고하여, column 형식에 맞게 자신만의 사용자, 책 DB를 사용할 수 있습니다.

주의사항입니다.
+ 첫째, 파일의 절대경로를 path에 입력해야 오류를 줄일 수 있습니다.
+ 둘째, file_name을 입력하는 곳에는 directory를 제외한 이름만 적어야 합니다.
+ 셋째, file_name에는 확장자를 포함하셔야 오류가 발생하지 않습니다.
+ 넷째, 현재 프로젝트에서는 사용자가 like를 누른 책 정보를 기반으로 추천리스트와 취향이미지를 생성하였습니다. 다른 데이터를 사용하기를 원한다면 App(BE)의 <a href="https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/App(BE)/main/models/database.py">database.py</a>의 User 객체를 참고하시기 바랍니다. 
+ 다섯째, pandas로 한글이 들어간 .csv 형식 파일을 읽어올 때는 ```encoding='UTF8'``` 또는 ```encoding='cp949'```를 사용해야 합니다. 만약 특정 encoding 방식에서 오류가 발생한다면, 다른 encoding 방식으로 수정해서 사용하시면 됩니다.
+ 여섯째, 파일을 생성하려는 경로에는 쓰기 권한이 있어야 하며, 절대경로를 포함한 파일명을 입력해야 합니다.


## 사용법
[test.py](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/AI/recommendation/test.py)에서 함수 호출의 예시를 확인하실 수 있습니다.

api에서 request에 대응하는 함수를 호출함으로써 사용할 수 있습니다. 아래 예시는 마이페이지 api를 담당하는 mypage.py에서 취향분석 이미지를 호출하는 코드입니다.

```buildoutcfg
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
            from main.recommendation import data_update
            data_update.update()                # data_update를 통해 먼저 사용자 정보를 DB에 맞게 최신화
            from main.recommendation import wordcloud_maker
            wordcloud_maker.exe_img(user_id)    # 최신화된 사용자 정보를 바탕으로 wordcloud_maker를 통해 취향정보 이미지 생성
            user_data='https://www.projectlib.tk/image/{}.png'.format(user_id)
```

주의사항입니다.
+ 이 프로젝트와 같이 api를 구현한 파일과 recommeder system을 구현한 파일의 파일의 경로가 다를 경우, api 파일에서 모듈을 import 할 때 경로에 유의하기 바랍니다. ex) ```from main.recommendation import data_update``` 등
+ wordcloud_maker.py의 exe_img(user_id), update.py의 update(), data_update.py의 update()는 file_path와 save_path 등의 환경변수를 소스코드에서 직접 지정하였으므로, 함수를 호출할 때 path, name을 설정하는 것이 아닌, wordcloud_maker.py, update.py, data_update.py에서 원하는 경로로 수정해주어야 합니다.

# 5. 발전방향
이 프로젝트의 추천시스템이 사용한 알고리즘은 collaborative filtering 방식 추천 알고리즘 중 하나인 Matrix Factorization입니다.

collaborative filtering이란 자신과 비슷한 평점을 매긴 다른 사용자의 평점을 이용해 아직 평점을 매기지 않은 책의 평점을 예측하는 알고리즘이라는 뜻입니다. 예를 들어, A가 'aa'라는 책을 좋아하고, B가 'aa'와 'bb'를 좋아한다면, A와 B는 같은 'aa'를 좋아하므로, 비슷한 흥미도를 가질 것이고, A도 B가 좋아하는 'bb'를 좋아할 것이라고 예측하는 알고리즘입니다. 

Matrix Factorization은 사용자의 like 유무에 따라 0과 1로 만들어진 사용자 평점 행렬을 분해하여 아직 like를 표기하지 않은 책에 대한 예측 점수를 계산하는 알고리즘을 말합니다.

collaborative filtering의 한계는 cold start problem입니다. 신간도서, 혹은 사용자 수가 적은 초기 배포단계에는 책에 대한 사용자의 like(평점) 데이터가 적기 때문에 사용자 간에 좋아하는 책 리스트가 겹치지 않는 상황이 빈번해지고, 결국 추천성능을 떨어뜨립니다.

이 문제를 해결하기 위해 같은 카테고리의 책만 읽은 사용자 데이터 dummy_user.csv를 생성하고, data_update.py가 DB의 사용자 정보를 API_test_users.csv에 최신화할 때 dummy_users를 포함시키도록 하였습니다. 이를 통해 사용자 수가 적은 초기 단계에도, 유사한 카테고리를 묶어줄 가상의 사용자 정보가 있어 자신이 좋아요를 누른 책과 유사한 책을 추천 받을 수 있게 하였습니다.
시간이 흘러 사용자 수가 많아지면 가상의 사용자 정보는 minor 해지고, 자연스럽게 실제 사용자 간의 좋아요에 기반하여 추천이 이루어집니다.  

이러한 노력에도, 아직 recommender system이 사용하지 못한 meta data가 많습니다.
책의 카테고리와 저자, 소개글로부터 찾아낼 수 있는 책 사이의 연관성, 사용자의 부대정보나 댓글, 게시판 활동으로부터의 사용자 간 연관성을 아직 활용하지 못하고 있습니다.
이러한 meta data를 포함시킨다면 추천시스템은 더 우수한, 사용자가 더 만족할만한 추천 결과를 만들 것입니다.

AI 파트에서는 추천시스템이 meta data를 활용할 수 있도록 앞으로 발전시킬 예정입니다.  

# 6. Contributing
다음 단계에 따라 이 프로젝트의 발전에 기여하실 수 있습니다!

+ 프로젝트 fork
+ 개발자님만의 branch 만들기
+ 코드 수정 후 commit
+ 개발자님만의 branch에 push
+ Pull Request 열기

# 7. 라이센스
MIT License에 따라 배포되고 있습니다. <a href="https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/LICENSE">LICENSE.txt</a>를 통해 더 자세한 license 정보를 확인하실 수 있습니다.


# 8. 개발자 정보
김승하(k2river) kstream35@gmail.com
