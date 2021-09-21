# 추천 시스템 설계

## 추천시스템이 사용할 데이터

* user rating (Collaborative Filtering에 사용)

    * explicit rating : 사용자가 남긴 별점
    * implicit rating : 사용자의 대출기록, 검색기록, 조회기록, 의견
    

* meta data (Content Based Filtering에 사용)

  * 책 : 태그, 저자
  * 사용자 : 나이, 부대, 관심사


## 추천대상에 따른 추천시스템

### __개인추천__  (__프로젝트의 핵심기능 "맞춤형 도서추천"__)
  * 데이터 : 사용자의 대출기록, 검색기록, 조회기록, 평점
  * 모델
    * CF : 
    * CBF : 
  
### 그룹 추천
  * 그룹 종류 : 전체, 부대별, 관심분야별
  * 모델 : 인기순, 조회순, 별점순 정렬
 
    (*인기순 : 일정기간 동안의 조회수, 별점 정보를 종합한 순서* )
  
### 연관도서 추천
  * 데이터 : 책의 태그, 저자
  * 모델 : Content Based Filtering Association Rule(CF), 장바구니
  
  
## 추천시스템 알고리즘

### Content Based Filtering

  사용자의 meta data(부대, 관심사)로부터 사용자 간의 연관성을 찾거나, 책의 meta data(태그, 저자, 책 소개 등)로부터 책 간의 연관성을 찾아 추천하는 시스템

  연관아이템추천 - 저자, 시리즈, A책 읽고 B책 읽으면.. (Youtube SK영상 kaggle 참고)
  
  
### Collaborative Filtering

  개인화 추천 목적
  
  * Matrix Factorization
  * 유사도 계산
  * wide_n_deep 모델

