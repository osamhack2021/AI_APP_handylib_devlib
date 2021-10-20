# recommendation
서버 내 /var/www/python_flask/main/recommendation/ 경로는,
추천리스트 생성 코드와 취향분석 이미지 생성 코드, 사용자와 책 정보가 저장된 곳입니다.

코드를 사용할 때 반드시 저희와 같은 경로를 사용할 필요는 없으며, 설정, 사용법을 참고하여 개발환경에 맞게 코드를 수정하시면 됩니다.

## 경로

+ ALS.py
+ API_test_books.csv
+ API_test_users.csv
+ data_update.py
+ dummy_generator.py
+ rec_category_2.csv
+ rec_pred_score_1.csv
+ recommendation.py
+ test.py
+ update.py
+ wordcloud_maker.py
+ NanumFontSetup_TTF_BARUNPEN
  + NanumBarunpenB.ttf
  + NanumBarunpenR.ttf
+ recommend_list
  + admin123.csv
  + userid_0.csv

### ALS.py
사용자 데이터(API_test_users.csv) 중 like column을 기반으로 추천점수 rec_pred_score_1.csv를 생성합니다.

### API_test_books.csv
책 정보가 저장되어 있습니다.

### API_test_users.csv
사용자 정보가 저장되어 있습니다.

### data_update.py
DB에서 User 정보를 받아서 API_test_users.csv를 최신화합니다.

### dummy_generator.py
cold start problem을 해결하기 위해 같은 카테고리의 책을 읽는 가상의 사용자 데이터 dummy_users.csv를 생성합니다.