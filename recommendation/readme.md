# 추천 시스템 설계

## 추천시스템이 사용할 데이터

* user rating (Collaborative Filtering에 사용)

    * explicit ratings : 사용자가 남긴 별점
    * implicit ratings : 사용자의 대출기록, 검색기록, 조회기록, 의견

    *implicit ratings의 점수화*
      *implicit ratings는 대출, 검색과 같은 사용자의 행동으로부터 사용자의 선호도를 추출하고 점수화하는 과정이 필요하다.*
   
      대출기록 2점, 추천되었을 때 조회기록 1점, 추천되지 않은 상태 0점, 추천되었지만 조회되지 않은 상태 -1점, 추천중지 설정시 -2점
    

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

  개인화 추천 목적
  
  explicit ratings, implicit ratings 사용
  
  모델별 성능을 분석 이후, 최고의 성능을 내는 모델 하나를 선택할지, 여러 모델의 결과들로부터 추천 후보군을 종합할지 결정

### Content Based Filtering

  사용자의 meta data(부대(?), 관심사)로부터 사용자 간의 연관성을 찾거나, 책의 meta data(태그, 저자, 책 소개 등)로부터 책 간의 연관성을 찾아 추천하는 시스템
  
  (부대 정보를 사용할 경우 사용자의 부대 정보가 코드로 변환되거나 암호화되어야 할 것 같음)

  연관아이템추천 - 저자, 시리즈, 장르, 태그
  
  
### Collaborative Filtering

   * memory-based : (1) item-based : 아이템 I에 대해 기존 평가들을 기반으로 유사한 아이템들의 집합을 고르고 아직 I에 대해 평가하지 않은 사용자 U의 평가는 사용자 U가 이미 평가한 아이템들 중 I와 유사한 N개의 아이템들을 골라 이 N개의 아이템에 대한 U의 평가를 기반으로 I에 대한 사용자 U의 평가를 예측한다. 사용자 A가 이전에 평가한 아이템들중  __유사도__ 가 높은 다른 아이템에 대한 사용자 A의 interactions을 예측하는 방식 (item-based collaborative filtering)
   * model-based : Gradient Descent처럼 optimization으로 parameter를 업데이트 하는 방식 (Matrix Factorization, wide and deep model)
   
   *content based : meta data(장르, 태그)가 유사한 item 추천     item-based : user-item rating matrix 기반 유사한 아이템을 추천*
  
#### (1) memory-based collaborative filtering
##### 유사도 측정 방법
  * Pearson correlation coefficient
  * Cosine similarity
  * euclidean distance



#### (2) Matrix Factorization (행렬 인수분해)
  사용자의 선호도가 몇 개의 hidden factors(embeddings)에 의해 결정된다는 아이디어로 시작한다.
  
  
  일반적으로 사용자는 도서관에 있는 책 중 일부만 읽고, 그중에도 일부만 평점을 남겼을 것이다. 따라서 사용자가 책에 남긴 평점을 행렬로 만들면, 거의 대부분이 평점이 기록되지 않아 0으로 표기된 Sparse Matrix(희소행렬)이 만들어진다. Sparse Matrix인 User-Item Ratings Matrix를, matrix factorization(행렬 인수분해)를 이용해 Latent Factor(잠재요소)를 학습한 두 행렬의 곱으로 나타내어 sparse matrix의 빈 곳이 채워진 complete matrix로 만드는 것이 목표이다. User-Item Ratings Matrix의 실제 평점값 - 분해한 행렬의 곱으로 얻은 예측한 평점값이 최소가 되도록 학습이 진행될 것이며, 학습이 종료되면 sparse matrix에서의 0은 complete matrix에서 예측값으로 기록될 것이다.
  
  ![image](https://user-images.githubusercontent.com/88222584/134134735-961b9c33-05e4-43fa-ac81-1afffd39c1fd.png)

  이 프로젝트에서는 Alternating Least Square(ALS, 교대제곱법)을 이용해 latent factor를 학습하여 예측평점을 구하고, 예측평점이 높은 상위 OO권을 추천 후보군에 등록될 것이다.

   (이후 code 올릴 때 hyperparameter 에서 latent factor k를 20개 사용하는 이유에 대한 논문 링크 추가)

#### (3) wide_n_deep 모델
Matrix Factorization은 original sparse 행렬을 두 개의 low rank orthogonal matrix로 분해하고 latent factors를 구하여 평점을 예측하는 것이 목표라면, neural net을 사용하는 모델은 matrix가 orthogonal일 필요 없이 embedding matrices 값을 업데이트한다는 점에서 MF의 확장이라고 볼 수 있다.

그중에도 wide and deep 모델은 memorization에 특화된 linear wide 모델과, generalization에 특화된 non-linear deep 모델의 장점을 합친 모델이다. wide and deep에 대한 논문은 https://arxiv.org/pdf/1606.07792.pdf 에서 읽을 수 있고, https://lsjsj92.tistory.com/597 에서 잘 설명되어 있어 내용 일부를 정리해보았다.

Memorization은 예컨데, 사용자가 A를 대출했고 B에 '좋아요'를 표시한 상황을 기억해서 A와 B 사이의 상관관계를 기억하는 것이다. 단점은 (1) 입력되지 않은 pair는 학습하지 못하는 것과 (2) 추천결과가 뻔하다는 것이다.

Memorization이 특정 feature 조합을 기억한다면, Generalization은 새로운 feature 조합을 만드는 등 다양성을 높이는 기능을 한다. 단점은 user-item interaction이 sparse하거나 high-rank여서 학습이 충분하지 않을 경우 관련 없는 아이템을 추천할 수 있다는 것이다.

wide and deep 모델은 feature interaction의 Memorization과 Generalization 모두가 가능하기에, wide-only와 deep-only 모델과 비교하여 크게 개선된 모델이다. 단순한 구조의 MF와 Neural net 모델 중에도 우수한 성능을 가진 wide and deep model의 추천 결과로부터 추천의 연관성과 만족도를 비교해볼 예정이다.



# 추천시스템 개발 일정
## 데이터 제작
## 모델 생성
## 모델별 성능 비교
## 서버에 추천시스템 탑재
