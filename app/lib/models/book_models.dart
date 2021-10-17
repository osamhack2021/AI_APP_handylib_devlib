import 'package:flutter/material.dart';

// 대여하기/대여불가능(부대에 없음), 누군가가 대여중입니다./대여중
enum BookStatusType {
  available,
  unavailableNobook,
  unavailableBorrowing,
  borrowing
}

Map<BookStatusType, String> bookStatusMap = {
  BookStatusType.available: "대출하기",
  BookStatusType.unavailableNobook: "대여불가능 (부대에 책이 없음)",
  BookStatusType.unavailableBorrowing: "대여불가능 (대여중)",
  BookStatusType.borrowing: "반납하기"
};

Map<BookStatusType, Color> bookStatusColorMap = {
  BookStatusType.available: Colors.lightGreen,
  BookStatusType.unavailableNobook: Colors.redAccent.withOpacity(0.6),
  BookStatusType.unavailableBorrowing: Colors.redAccent.withOpacity(0.6),
  BookStatusType.borrowing: Colors.lightBlue
};

class Book {
  final String title;
  final String author;
  final String pubDate;
  final String description;
  final String coverUrl;
  final String isbn;
  final String publisher;
  final String category;

  Book(this.title, this.author, this.pubDate, this.description, this.coverUrl,
      this.publisher, this.category, this.isbn);

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        pubDate = json['pubDate'],
        description = json['description'],
        isbn = json['isbn'],
        coverUrl = json['cover'],
        publisher = json['publisher'],
        category = json['categoryName'];
}

List<int> jinjungIsbnList = [
  9788936438036,
  9791162143056,
  9788960518025,
  9791165366087,
  9788954672214,
  // 9788932920405,
  // 9788998274795,
  // 9791130629636,
  // 9788901244600,
  // 9788967358020,
  // 9791130630366,
  // 9788925556253,
  // 9791187289852,
  // 9791158740757,
  // 9788901243658,
  // 9788962622713,
  // 9791196918033,
  // 9791163031512,
  // 9788950985981,
  // 9788908060623,
];

Map<int, String> categoryMap = {
  50930: "과학소설(SF)",
  50933: "액션/스릴러소설",
  50926: "추리/미스터리소설",
  50917: "한국소설",
  8537: "	컴퓨터공학/전산학 개론",
  55890: "건강/취미/레저",
  53488: "패션/뷰티",
  170: "경제경영",
  172: "재테크/투자",
  336: "자기계발",
};
