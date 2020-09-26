// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'book.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
class _$BookTearOff {
  const _$BookTearOff();

// ignore: unused_element
  _Book call(
      {String id,
      String md5,
      String title,
      String author,
      String year,
      String edition,
      String publisher,
      String extension}) {
    return _Book(
      id: id,
      md5: md5,
      title: title,
      author: author,
      year: year,
      edition: edition,
      publisher: publisher,
      extension: extension,
    );
  }

// ignore: unused_element
  Book fromJson(Map<String, Object> json) {
    return Book.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Book = _$BookTearOff();

/// @nodoc
mixin _$Book {
  String get id;
  String get md5;
  String get title;
  String get author;
  String get year;
  String get edition;
  String get publisher;
  String get extension;

  Map<String, dynamic> toJson();
  $BookCopyWith<Book> get copyWith;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String md5,
      String title,
      String author,
      String year,
      String edition,
      String publisher,
      String extension});
}

/// @nodoc
class _$BookCopyWithImpl<$Res> implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  final Book _value;
  // ignore: unused_field
  final $Res Function(Book) _then;

  @override
  $Res call({
    Object id = freezed,
    Object md5 = freezed,
    Object title = freezed,
    Object author = freezed,
    Object year = freezed,
    Object edition = freezed,
    Object publisher = freezed,
    Object extension = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      md5: md5 == freezed ? _value.md5 : md5 as String,
      title: title == freezed ? _value.title : title as String,
      author: author == freezed ? _value.author : author as String,
      year: year == freezed ? _value.year : year as String,
      edition: edition == freezed ? _value.edition : edition as String,
      publisher: publisher == freezed ? _value.publisher : publisher as String,
      extension: extension == freezed ? _value.extension : extension as String,
    ));
  }
}

/// @nodoc
abstract class _$BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$BookCopyWith(_Book value, $Res Function(_Book) then) =
      __$BookCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String md5,
      String title,
      String author,
      String year,
      String edition,
      String publisher,
      String extension});
}

/// @nodoc
class __$BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res>
    implements _$BookCopyWith<$Res> {
  __$BookCopyWithImpl(_Book _value, $Res Function(_Book) _then)
      : super(_value, (v) => _then(v as _Book));

  @override
  _Book get _value => super._value as _Book;

  @override
  $Res call({
    Object id = freezed,
    Object md5 = freezed,
    Object title = freezed,
    Object author = freezed,
    Object year = freezed,
    Object edition = freezed,
    Object publisher = freezed,
    Object extension = freezed,
  }) {
    return _then(_Book(
      id: id == freezed ? _value.id : id as String,
      md5: md5 == freezed ? _value.md5 : md5 as String,
      title: title == freezed ? _value.title : title as String,
      author: author == freezed ? _value.author : author as String,
      year: year == freezed ? _value.year : year as String,
      edition: edition == freezed ? _value.edition : edition as String,
      publisher: publisher == freezed ? _value.publisher : publisher as String,
      extension: extension == freezed ? _value.extension : extension as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Book implements _Book {
  _$_Book(
      {this.id,
      this.md5,
      this.title,
      this.author,
      this.year,
      this.edition,
      this.publisher,
      this.extension});

  factory _$_Book.fromJson(Map<String, dynamic> json) =>
      _$_$_BookFromJson(json);

  @override
  final String id;
  @override
  final String md5;
  @override
  final String title;
  @override
  final String author;
  @override
  final String year;
  @override
  final String edition;
  @override
  final String publisher;
  @override
  final String extension;

  @override
  String toString() {
    return 'Book(id: $id, md5: $md5, title: $title, author: $author, year: $year, edition: $edition, publisher: $publisher, extension: $extension)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Book &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.md5, md5) ||
                const DeepCollectionEquality().equals(other.md5, md5)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.edition, edition) ||
                const DeepCollectionEquality()
                    .equals(other.edition, edition)) &&
            (identical(other.publisher, publisher) ||
                const DeepCollectionEquality()
                    .equals(other.publisher, publisher)) &&
            (identical(other.extension, extension) ||
                const DeepCollectionEquality()
                    .equals(other.extension, extension)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(md5) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(edition) ^
      const DeepCollectionEquality().hash(publisher) ^
      const DeepCollectionEquality().hash(extension);

  @override
  _$BookCopyWith<_Book> get copyWith =>
      __$BookCopyWithImpl<_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BookToJson(this);
  }
}

abstract class _Book implements Book {
  factory _Book(
      {String id,
      String md5,
      String title,
      String author,
      String year,
      String edition,
      String publisher,
      String extension}) = _$_Book;

  factory _Book.fromJson(Map<String, dynamic> json) = _$_Book.fromJson;

  @override
  String get id;
  @override
  String get md5;
  @override
  String get title;
  @override
  String get author;
  @override
  String get year;
  @override
  String get edition;
  @override
  String get publisher;
  @override
  String get extension;
  @override
  _$BookCopyWith<_Book> get copyWith;
}
