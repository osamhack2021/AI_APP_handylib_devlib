class Book {
  final String title;
  final String author;
  final String pubDate;
  final String description;
  final int isbn13;
  final String coverUrl;
  final String publisher;
  final String category;

  Book(this.title, this.author, this.pubDate, this.description, this.isbn13,
      this.coverUrl, this.publisher, this.category);

  Book.fromJson(Map<String, dynamic> json)
      : title = json['item'][0]['title'],
        author = json['item'][0]['author'],
        pubDate = json['item'][0]['pubDate'],
        description = json['item'][0]['description'],
        isbn13 = int.parse(json['item'][0]['isbn13']),
        coverUrl = json['item'][0]['cover'],
        publisher = json['item'][0]['publisher'],
        category = json['item'][0]['categoryName'];
}
