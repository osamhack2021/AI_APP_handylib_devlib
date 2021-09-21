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
  
  모델별 성능을 분석하고 최고의 성능을 내는 모델 하나를 선택하거나 여러 모델의 결과를 합쳐서 추천할 예정
  
#### Matrix Factorization (행렬 인수분해)
  일반적으로 사용자는 도서관에 있는 책 중 일부만 읽고, 그중에도 일부만 평점을 남겼을 것이다. 따라서 사용자가 책에 남긴 평점을 행렬로 만들면, 거의 대부분이 평점이 기록되지 않아 0으로 표기된 Sparse Matrix(희소행렬)이 만들어진다. Sparse Matrix인 User-Item Ratings Matrix를, matrix factorization(행렬 인수분해)를 이용해 Latent Factor(잠재요소)를 학습한 두 행렬의 곱으로 나타내어 sparse matrix의 빈 곳이 채워진 complete matrix로 만드는 것이 목표이다. User-Item Ratings Matrix의 실제 평점값 - 분해한 행렬의 곱으로 얻은 예측한 평점값이 최소가 되도록 학습이 진행될 것이며, 학습이 종료되면 sparse matrix에서의 0은 complete matrix에서 예측값으로 기록될 것이다.
  
  ![image](https://user-images.githubusercontent.com/88222584/134134735-961b9c33-05e4-43fa-ac81-1afffd39c1fd.png)

  이 프로젝트에서는 Alternating Least Square(ALS, 교대제곱법)을 이용해 latent factor를 학습하여 예측평점을 구하고, 예측평점이 높은 상위 OO권을 추천 후보군에 등록될 것이다.

   (이후 code 올릴 때 hyperparameter 에서 latent factor k를 20개 사용하는 이유에 대한 논문 링크 추가)

#### 유사도 계산

#### wide_n_deep 모델


# 추천시스템 개발 일정
## 데이터 제작
## 모델 생성
## 모델별 성능 비교
## 서버에 추천시스템 탑재
