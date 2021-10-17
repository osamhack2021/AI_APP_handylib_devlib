
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

<span>Readme 목차</span>
  <ol>
    <li>
      <a href="#about-the-project">AI (recommendation)</a>
    </li>
    <li>
      <a href="#getting-started">시작하기</a>
      <ul>
        <li><a href="#prerequisites">요구사항</a></li>
        <li><a href="#installation">설치</a></li>
      </ul>
    </li>
    <li><a href="#usage">사용법</a></li>
    <li><a href="#license">라이센스</a></li>
    <li><a href="#contact">개발자 정보</a></li>
  </ol>

<!-- ABOUT THE PROJECT -->



# AI (recommendation)
AI에서는 개인별 책 추천시스템과 사용자의 취향정보 시각화를 담당하였습니다.

추천시스템 개발과정 및 보다 자세한 설명을 원하신다면 아래 링크에서 개발문서를 확인해주시기 바랍니다.

[notion](https://www.notion.so/recommender-system-e97a10b6db184d2aabb2f67b3eac3b85)

## 책 추천시스템
서버에서 사용자 및 책 정보를 요청하여, Matrix Factorization 기반 추천 리스트를 생성합니다.

## 취향정보 시각화
사용자가 좋아요를 누른 책을 기반으로 사용자가 좋아하는 카테고리를 wordcloud로 시각화합니다.

# 시작하기
## 요구사항
- wordcloud==1.8.1
- pandas==1.3.3
- numpy>=1.19.5
- apscheduler==3.8.0

## 설치
### Directory
+ recommendation
    + ALS.py
    + example_file_path
        + recommend_list
            + admin.csv
            + abcd.csv
        + img
            + admin.png
            + abcd.png
        + APP_test_books.csv
        + APP_test_users.csv
        + rec_pred_score_1.csv
    + random_user_generator.py (testcase generator)
    + readme.md
    + recommendation.py
    + update.py
    + wordcloud_maker.py
    + requirements.txt





# Test
테스트 사용법은 다음과 같습니다

```
$ python test.py
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
