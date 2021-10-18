

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

<span>Readme 목차</span>
  <ol>
    <li>
      <a href="# AI (recommendation)">AI (recommendation)</a>
    </li>
    <li>
      <a href="# AI (recommendation)">책 추천시스템</a>
    </li>
    <li>
      <a href="# AI (recommendation)">취향정보 시각화</a>
    </li>
    <li>
      <a href="#getting-started">시작하기</a>
      <ul>
        <li><a href="#prerequisites">요구사항</a></li>
        <li><a href="#installation">설치</a></li>
        <li><a href="#installation">설정</a></li>
        <li><a href="#installation">사용법</a></li>
      </ul>
    </li>
    <li><a href="#usage">발전 방향</a></li>
    <li><a href="#license">라이센스</a></li>
    <li><a href="#contact">개발자 정보</a></li>
  </ol>

<!-- ABOUT THE PROJECT -->



# 1. AI (recommendation)
AI에서는 개인별 책 추천시스템과 사용자의 취향정보 시각화를 담당하였습니다.

추천시스템 개발과정과 보다 자세한 설명을 원하신다면 링크에서 AI 파트의 개발문서를 확인해주시기 바랍니다.
[AI [recommender system]](https://www.notion.so/recommender-system-e97a10b6db184d2aabb2f67b3eac3b85)

# 2. 책 추천시스템
서버에서 사용자 및 책 정보를 요청하여, Matrix Factorization 기반 추천 리스트 30권을 생성합니다.

API_test_users.csv : userid_0의 like는 [1247, 164, 89, 1219, 903]입니다.

+ 1247 : 국내도서>수험서/자격증>공무원 수험서>소방공무원(승진)>기타 과목
+ 164 : 국내도서>사회과학>국방/군사학>국내외 군사사정
+ 89 : 국내도서>자기계발>성공>성공담
+ 1219 : 국내도서>자기계발>성공>성공담
+ 국내도서>전집/중고전집>창작동화

![img_1.png](img_1.png)

userid_0.csv에 나온 추천도서는 [1030, 1413, 626, 1150, 167] 등 30권입니다.

+ 1030 : 조선왕조실톡 6 - 조선의 두 번째 영광 (국내도서>역사>조선사>조선후기(영조~순종))
+ 1413 : 삶의 덫에서 벗어나 새로운 나를 열기 (국내도서>자기계발>힐링>마음 다스리기))
+ 626 : 숲, 다시 보기를 권함 (국내도서>과학>생명과학>생태학)
+ 1150 : 회사에서 나만 그래? - 언니들이 알려주는 조직생활 노하우 26 (국내도서>자기계발>여성의 자기계발)
+ 167 : 우린 다르게 살기로 했다 - 혼자는 외롭고 함께는 괴로운 사람들을 위한 마을공동체 탐사기 (국내도서>사회과학>사회운동>사회운동 일반)

![img.png](img.png)

# 3. 취향정보 시각화
사용자가 좋아요를 누른 책을 기반으로 사용자가 좋아하는 카테고리를 wordcloud로 시각화합니다.

![img_3.png](img_3.png)

# 4. 시작하기
## 요구사항
- wordcloud==1.8.1
- pandas==1.3.3
- numpy>=1.19.5

/var/www/python_flask/ 경로에서 다음 코드를 실행하여 필요한 모듈을 설치합니다. 
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
    + random_user_generator.py
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

file_path는 recommendation에 해당하는 경로를 의미합니다.
책, 사용자 정보를 담은 파일, 추천리스트와 취향분석 이미지를 생성하는 코드가 저장된 경로를 적어주시면 됩니다.
```buildoutcfg
# 개인 PC에서 실행할 경우
file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'

# 서버 venv에서 실행할 경우 
file_path = '/var/www/python_flask/recommendation/'
```
github로 공유하는 파일 외에 별도로 파일을 만들어 사용하고 싶다면, 파일명 변수도 수정해야 합니다.
```
user_file_name = 'API_test_users.csv'
```

# Contributing
Follow the steps below to contribute this project.

Fork the Project
Create your Branch
Commit your Changes
Push to the Branch
Open a Pull Request

# License
Distributed under the MIT License. See LICENSE.txt<TODO:add link> for more information.


# Contact
김승하(k2river) kstream35@gmail.com
