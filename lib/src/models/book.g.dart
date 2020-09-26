// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$_$_BookFromJson(Map json) {
  return _$_Book(
    id: json['id'] as String,
    md5: json['md5'] as String,
    title: json['title'] as String,
    author: json['author'] as String,
    year: json['year'] as String,
    edition: json['edition'] as String,
    publisher: json['publisher'] as String,
    extension: json['extension'] as String,
  );
}

Map<String, dynamic> _$_$_BookToJson(_$_Book instance) => <String, dynamic>{
      'id': instance.id,
      'md5': instance.md5,
      'title': instance.title,
      'author': instance.author,
      'year': instance.year,
      'edition': instance.edition,
      'publisher': instance.publisher,
      'extension': instance.extension,
    };
