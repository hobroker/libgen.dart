import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

part 'book.g.dart';

@freezed
abstract class Book with _$Book {
  factory Book({
    String id,
    String md5,
    String title,
    String author,
    String year,
    String edition,
    String publisher,
    String extension,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
