class Book {
  final String id;
  final String md5;
  final String title;
  final String author;
  final String year;
  final String edition;
  final String publisher;
  final String extension;

  Book({
    this.id,
    this.md5,
    this.title,
    this.author,
    this.year,
    this.edition,
    this.publisher,
    this.extension,
  });

  Book.fromJson(Map json)
      : id = json['id'],
        md5 = json['md5'],
        title = json['title'],
        author = json['author'],
        year = json['year'],
        edition = json['edition'],
        publisher = json['publisher'],
        extension = json['extension'];

  Map<String, String> toJson() => {
        'id': id,
        'md5': md5,
        'title': title,
        'author': author,
        'year': year,
        'edition': edition,
        'publisher': publisher,
        'extension': extension,
      };
}
