import 'package:libgen/src/models/book.dart';
import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

import '../__mocks__/book_mock.dart';

void main() {
  group('Book', () {
    test('throws an error if `id` is missing', () {
      try {
        // ignore: missing_required_param
        Book(md5: '1');
      } catch (e) {
        expect(e.message, equals('id is required'));
      }
    });

    test('throws an error if `md5` is missing', () {
      try {
        // ignore: missing_required_param
        Book(id: '1');
      } catch (e) {
        expect(e.message, equals('md5 is required'));
      }
    });

    group('.fromJson()', () {
      test('returns the expected Book instance', () {
        final result = Book.fromJson(darkMatterBook.json);

        expect(result, equals(darkMatterBook.object));
      });
    });

    group('.toJson()', () {
      test('returns a Map with expected keys', () {
        print(darkMatterBook.object.toJson().keys);
        expect(darkMatterBook.object.toJson().keys, [
          'id',
          'md5',
          'title',
          'author',
          'year',
          'edition',
          'publisher',
          'identifier',
          'extension',
          'descr',
        ]);
      });
    });

    group('.toString()', () {
      test('returns the expected String', () {
        expect(darkMatterBook.object.toString(),
            equals('Book ${beautify(darkMatterBook.object.toJson())}'));
      });
    });

    group('.hashCode', () {
      test('returns the expected String', () {
        expect(darkMatterBook.object.hashCode, equals(230930195));
      });
    });
  });
}
