
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
    <li>
      <a href="#Back-End">Back-End</a>
      <ul>
        <li><a href="#built-with">개발 도구</a></li>
      </ul>
    </li>
    <li><a href="#usage">사용법</a></li>
    <li><a href="#test">Test</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>



## Back-End
Back-End에서는 python flask와 mongodb를 사용하여 데이터베이스를 구축하고 서버 통신이 가능하도록 REST API를 개발하였습니다.


<a id = "built-with"></a>

## 개발 도구

+ [python, Flask](https://flask.palletsprojects.com/en/2.0.x/)
+ [MongoDB](https://www.mongodb.com/cloud/atlas/lp/try2?utm_source=google&utm_campaign=gs_apac_south_korea_search_core_brand_atlas_desktop&utm_term=mongodb&utm_medium=cpc_paid_search&utm_ad=e&utm_ad_campaign_id=12212624365&gclid=Cj0KCQjwqp-LBhDQARIsAO0a6aJDBv9E4rs6c4Na0WH_tBu-0TSDAuFCQlRaPZCRUj4o2zFxZ1CTwHgaAvqKEALw_wcB), [mongoengine](https://flask.palletsprojects.com/en/2.0.x/patterns/mongoengine/)
+ [Microsoft Azure cloud](https://azure.microsoft.com/ko-kr/)
+ [Git](https://git-scm.com/)
+ [apache2](https://httpd.apache.org/)
+ [wsgi](https://docs.python.org/ko/3/library/wsgiref.html)
+ [cloudflare](https://www.cloudflare.com/ko-kr/)
+ [Vultr DNS](https://www.vultr.com/docs/introduction-to-vultr-dns)

## Prerequisites
* pip
  ```sh
  $ pip install -r requirements.txt
  ```


## Test

테스트 사용법은 다음과 같습니다
* pip
  ```sh
  $ python test.py
  ```

## Contributing
코드를 사용하기 앞서 도서 검색에 [naver OpenAPI](https://developers.naver.com/main/)를 이용하였으므로 키 발급이 필요합니다. client_id와 client_secret을 발급받은 뒤 .env 파일을 생성해서 저장하시면 됩니다. 많은 기여 부탁드립니다!

1. Fork the Project
2. Create your Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

## License
Distributed under the MIT License. See [LICENSE.txt](https://github.com/osamhack2021/AI_APP_handylib_devlib/blob/main/LICENSE) for more information.


<a id = "contact"></a>

## 개발자 정보
김수민(Eeap) - kdg97811@naver.com    </br>
고명진(B-1GO) - mj2000go@naver.com    </br>