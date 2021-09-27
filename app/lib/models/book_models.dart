class Book {
  String imageUrl;
  String title;
  String categories;
  int year;
  String country;
  int length;
  String description;
  List<String> screenshots;

  Book({
    required this.imageUrl,
    required this.title,
    required this.categories,
    required this.year,
    required this.country,
    required this.length,
    required this.description,
    required this.screenshots,
  });
}

final List<Book> movies = [
  Book(
    imageUrl: 'assets/images/spiderman.jpeg',
    title: '초격차 투자법 - 시장을 이긴 숨은 고수 11인의',
    categories: 'Fantasy, Sci-fi',
    year: 2018,
    country: 'USA',
    length: 129,
    description:
        '주식 고수들이 손꼽는 인생 책, 전 세계 100만 부 이상 판매된 베스트셀러 시리즈 ‘시장의 마법사들’이 더 강력하게 돌아왔다. 주식과 선물시장의 전설들을 인터뷰해 그들의 투자 기법을 밝힌 ‘시장의 마법사들’은 고수들이 찾아 읽는 투자 고전으로 손꼽힌다. 9년 만에 출간된 신간 《초격차 투자법》에서는 나 홀로 투자에 뛰어든 개인 투자자 11명을 만난다.',
    screenshots: [
      'assets/images/spiderman_0.jpg',
      'assets/images/spiderman_1.jpg',
      'assets/images/spiderman_2.jpg',
    ],
  ),
  Book(
    imageUrl: 'assets/images/nutcracker.jpg',
    title: 'The Nutcracker And The Four Realms',
    categories: 'Adventure, Family, Fantasy',
    year: 2018,
    country: 'USA',
    length: 100,
    description:
        'All Clara wants is a key - a one-of-a-kind key that will unlock a box that holds a priceless gift from her late mother. A golden thread, presented to her at godfather Drosselmeyer\'s annual holiday party, leads her to the coveted key-which promptly disappears into a strange and mysterious parallel world. It\'s there that Clara encounters a soldier named Phillip, a gang of mice and the regents who preside over three Realms: Land of Snowflakes, Land of Flowers, and Land of Sweets. Clara and Phillip must brave the ominous Fourth Realm, home to the tyrant Mother Ginger, to retrieve Clara\'s key and hopefully return harmony to the unstable world.',
    screenshots: [
      'assets/images/nutcracker_0.jpg',
      'assets/images/nutcracker_1.jpg',
      'assets/images/nutcracker_2.jpg',
    ],
  ),
  Book(
    imageUrl: 'assets/images/toystory.jpg',
    title: 'Toy Story 4',
    categories: 'Adventure, Fantasy',
    year: 2019,
    country: 'USA',
    length: 100,
    description:
        'Woody, Buzz Lightyear and the rest of the gang embark on a road trip with Bonnie and a new toy named Forky. The adventurous journey turns into an unexpected reunion as Woody\'s slight detour leads him to his long-lost friend Bo Peep. As Woody and Bo discuss the old days, they soon start to realize that they\'re two worlds apart when it comes to what they want from life as a toy.',
    screenshots: [
      'assets/images/toystory_0.jpg',
      'assets/images/toystory_1.jpg',
      'assets/images/toystory_2.jpg',
    ],
  ),
];

final List<String> myList = [
  'assets/images/shigatsu_wa_kimi_no_uso.jpg',
  'assets/images/plastic_memories.png',
  'assets/images/erased.jpg',
  'assets/images/seven_deadly_sins.jpg',
  'assets/images/cobra_kai.jpg',
];

final List<String> popular = [
  'assets/images/stranger_things.jpg',
  'assets/images/endgame.jpg',
  'assets/images/oitnb.jpg',
  'assets/images/daredevil.jpg',
];
