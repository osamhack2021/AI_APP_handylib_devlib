class UnitBook {
  final String title, pubDate, tag;
  final int isbn;

  UnitBook(this.title, this.pubDate, this.tag, this.isbn);

  
}

List<UnitBook> getUnitBookList() {
  List<UnitBook> myUnitBookList = [];
  UnitBook myUnitBook = UnitBook('text book title', 'pulblication date', 'tag', 123456789);
  for(int i = 1; i <= 10; i++) {
    myUnitBookList.add(myUnitBook);
  }
  print(myUnitBookList);
  return myUnitBookList;
}