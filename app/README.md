<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">내 손 안의 진중문고, HandyLib</h3>

  <p align="center">
    진중문고를 내 손안으로!
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template"><strong>[ View Docs ]</strong></a>
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template"><strong>[ View Demo ]</strong></a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->


<span>Readme 목차</span>
  <ol>
    <li>
      <a href="#about-the-project">프론트엔드</a>
      <ul>
        <li><a href="#built-with">개발 도구</a></li>
      </ul>
    </li>
  <li><a href="#pageExplanation">페이지 소개</a>
    <ul>
      <li>플로우차트</li>
      <li>메인 페이지 소개</li>
      <li>기타 페이지 소개</li>
    </ul>
  </li>
  <li>데이터 모델
    <ul>
      <li>객체 구조</li>
      <li>Primary coior 정의</li>
    </ul>
  </li>
  <li>사용한 constants</li>
  <li>발전 방향</li>
  
  <li>
      <a href="#getting-started">설치 방법</a>
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
<!-- <img src = "" width = 300> -->
# 프론트엔드

[![Product Name Screen Shot][product-screenshot]](https://example.com)

프론트엔드에서는 flutter를 이용하여 앱 UI/UX 및 개인화 기능을 개발하였습니다. 


<a id = "pageExplanation"></a>
<br><br>
# UI/UX

## 플로우차트
![Untitled Diagram drawio](https://user-images.githubusercontent.com/19871043/137645027-70095b17-478a-4a11-9cc4-e6fa3c034b4e.png)
<br><br>

## 메인페이지

메인 페이지는 총 다섯 개의 탭으로 구성되어 있습니다. 탭 구성은 아래와 같습니다.
<ol>
  <li><a href = "#ebookLib">전자 도서관</a></li>
  <li><a href = "#myBook">나의 서재</a></li>
  <li><a href = "#unitLib">부대 도서관</a></li>
  <li><a href = "#board">게시판</a></li>
  <li><a href = "#myPage">마이페이지</a></li>
 </ol>
 
<a id = "ebookLib"></a>
<br><br>
### 📕 전자도서관

<img src = "https://user-images.githubusercontent.com/19871043/137631076-eb59683e-a0d6-4f45-a467-c0fa00690e3b.png" height = 500> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/19871043/137631425-2cf711c2-79b6-43f3-aef1-bdec65753ae5.png" height = 500>

<br>
전자도서관은 산발적으로 나뉘어 있던 기존의 군 전자도서관 시스템을 <strong>하나로 통합한 시스템</strong>입니다. 
<br><br>
이 페이지에서는 다음 기능들을 지원합니다:
<br> <br>
<ul>
  <li><strong>당신을 위한 AI의 Pick</strong><br>사용자가 좋아요를 누른 책을 AI가 분석하여 사용자가 좋아할 만한 책을 추천합니다.</li><br>
  <li><strong>이번 분기의 진중문고</strong><br>각 분기마다 새로 보급된 진중문고를 ebook으로 만나볼 수 있도록 해 줍니다.</li><br>
  <li><strong>장르 별 도서</strong><br>장르 별로 사용자가 다양한 책을 접근할 수 있도록 뷰어를 제공합니다.</li><br>
</li>

<br>
목록의 책을 누르면 책의 상세 정보를 볼 수 있습니다. 

<br><br>

<img src = "https://user-images.githubusercontent.com/19871043/137631606-67417469-5c2c-4ff8-8af3-ae14f4d4725a.png" height = 500>


<br>
이 페이지에서 책을 대출하거나, 좋아요를 누를 수 있습니다.
<br><br>
대출한 책은 <a href = "#myBook">나의 서재</a>에서 확인할 수 있습니다.
<br><br>
<strong>좋아요를 누른 책은 AI가 사용자의 취향을 분석하는 데 반영</strong>됩니다.
  <br><br>
  
  
<a id = "myBook"></a>
<br><br>
### 📗 나의 서재
<br>
나의 서재는 다음 기능들로 구성되어 있습니다 : 
<br><br>
<ul>
  <li><b>나의 취향 분석</b><br>내가 고른 책들의 취향을 워드클라우드로 보여줍니다.</li><br>
  <li><b>대출한 도서</b><br>내가 대출한 도서들의 목록을 보여줍니다. 전자책으로 열람이 가능합니다.</li><br>
 </ul>

<img src = "https://user-images.githubusercontent.com/19871043/137631825-9c378c6a-2b73-44a4-96d0-060fa9ae4fd9.png" height = 500>


<br>

  (열람 사진)

<a id = "unitLib"></a>
  <br><br>
### 📘 부대 도서관

부대 도서관은 우리 부대의 도서관에 있는 실제 책들을 관리/이용할 수 있도록 하는 시스템입니다.
<br><br>
우리 부대에 새로 들어온 책들, 우리 부대의 인기 도서들, 우리 부대의 전체 책들을 열람할 수 있습니다.
<br><br>
이 데이터들은 부대 별로 따로 관리됩니다.
<br><br>
만약 우리 부대에 있는 책들이 ebook 데이터가 존재한다면 ebook도 열람할 수 있습니다.
<br><br>


<img src = "https://user-images.githubusercontent.com/19871043/137636455-3b8728b1-5a87-4216-8008-78fc905bea69.png" height = 500>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/19871043/137642721-bccede16-902a-4106-b201-76c79516a8ae.png" height = 500>
<br><br>
<img src = "https://user-images.githubusercontent.com/19871043/137642725-bb150856-0845-4827-a9c3-246eda295aa0.png" height = 500>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/19871043/137642727-0e38238d-6687-4487-a919-8b568bb48ee5.png" height = 500>


<a id = "board"></a>
<br><br>
### 📙 게시판

게시판은 총 세 개의 기능으로 나누어집니다.
<br><br>
<ul>
  <li><b>대회 개최 게시판</b><br>장병들의 독서를 장려하기 위한 각종 대회를 개최하는 게시판입니다.</li>
  <li><b>독서 토론 게시판</b><br>장병들이 독서 후 자유롭게 독서토론을 할 수 있는 게시판입니다.</li>
  <li><b>자유 게시판</b><br>특정한 주제에 얽매이지 않고 자유롭게 이야기를 나눌 수 있는 게시판입니다.</li>
</ul>

<img src = "https://user-images.githubusercontent.com/19871043/137643018-2f6bc01f-1d6f-4fb6-a55d-9c52bd32a228.png" height = 500>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/19871043/137643019-1fa04067-db3c-4c3a-a8b0-6d37b85ecf33.png" height = 500>
<br><br>
<img src = "https://user-images.githubusercontent.com/19871043/137643022-cef1ab78-9f7e-4934-9482-bffa686fb5a3.png" height = 500>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/19871043/137643024-2385b23f-192d-427b-835f-a2bcf0cc1f30.png" height = 500>
<br><br>

<a id = "myPage"></a>
<br><br>
### 📒 마이페이지

내 개인정보를 수정하는 기능을 제공합니다.
<br><br>
  <img src = "https://user-images.githubusercontent.com/19871043/137643200-6a735ec4-ffe7-48ac-8f93-57bd5503bd49.png" height = 500>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src = "https://user-images.githubusercontent.com/19871043/137643202-eb1192b6-dc97-4118-acb0-181b9de56179.png" height = 500>
<br><br>

## 기타 페이지
회원가입 + 로그인 등


# 데이터 모델
## 객체 구조
### User
|  |name|userId|password|email|unit|rank|
|--|----|------|--------|-----|----|----|
|  |사용자명|사용자 id|사용자 비밀번호|사용자 이메일|사용자 소속 부대|사용자 계급|


### Built With

This section should list any major frameworks/libraries used to bootstrap your project. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

- [Next.js](https://nextjs.org/)
- [React.js](https://reactjs.org/)
- [Vue.js](https://vuejs.org/)
- [Angular](https://angular.io/)
- [Svelte](https://svelte.dev/)
- [Laravel](https://laravel.com)
- [Bootstrap](https://getbootstrap.com)
- [JQuery](https://jquery.com)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

- npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = "ENTER YOUR API";
   ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#top">back to top</a>)</p>
