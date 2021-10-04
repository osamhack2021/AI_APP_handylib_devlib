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
      : title = json['title'],
        author = json['author'],
        pubDate = json['pubDate'],
        description = json['description'],
        isbn13 = int.parse(json['isbn13']),
        coverUrl = json['cover'],
        publisher = json['publisher'],
        category = json['categoryName'];
}
