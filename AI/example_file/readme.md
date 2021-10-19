# example_file
추천시스템이 사용한 input data와 output data를 공유하는 공간입니다.

## directory
+ example_file
    + recommend_list
      + admin.csv
      + abcd.csv
    + img
      + admin.png
      + abcd.png
    + APP_test_books.csv
    + APP_test_users.csv
    + rec_pred_score_1.csv

## recommend_list
recommend_list는 recommendation.py 내 recommendation 함수가 생성한 추천리스트가 저장되는 directory입니다.
사용자의 id의 이름을 따서 (user_id).csv가 저장됩니다.

## img
img는 wordcloud_maker.py의 exe_img 함수가 실행되면서 생성된 취향분석 이미지가 저장되는 directory입니다.
사용자의 id의 이름을 따서 (user_id).png가 저장됩니다.

## APP_test_books.csv
온라인 서점 알라딘에서 제공하는 알라딘 api를 이용해 1440권의 제목, 저자, 출판일, 카테고리명 등의 데이터를 받아 저장한 .csv 형식 파일입니다.
저희 프로젝트에서는 이 파일의 책 정보를 DB에 입력하여 사용하였습니다.

## APP_test_users.csv
dummy_generator.py가 생성한 dummy_user 300명의 이름, 아이디, 좋아하는 책 등의 데이터를 저장한 .csv 형식 파일입니다.
data_update.py의 update 함수를 통해, DB에서 사용자 정보를 최신화할 수 있습니다.
이 정보를 바탕으로 ALS.py에서 추천점수를 생성하고, wordcloud_maker.py에서 사용자 취향분석 이미지를 생성합니다.

## rec_pred_score_1.csv
ALS.py의 predict 함수가 생성한, user-book 추천점수가 저장된 .csv 형식 파일입니다.
모든 사용자별로, 모든 책에 대한 추천점수가 기록되어 있습니다.
이 정보를 바탕으로 recommendation.py에서 추천리스트를 생성합니다.