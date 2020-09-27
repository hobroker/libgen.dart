import 'package:libgen/src/models/book.dart';
import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

import '../__mocks__/results.dart';

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

    group('fromJson', () {
      test('returns the expected Book instance', () {
        final result = Book.fromJson(darkMatterJson);

        expect(result, equals(darkMatterBook));
      });
    });

    group('toJson', () {
      test('returns the expected String', () {
        expect(
            darkMatterBook.toJson(),
            equals({
              'id': '1591104',
              'md5': '7eabed69e5f2762211ec97ef972e8761',
              'title': 'Dark Matter',
              'author': 'Blake Crouch',
              'year': '2016',
              'edition': '',
              'publisher': 'Crown',
              'descr': 'A mindbending, relentlessly surprising thriller',
              'identifier': '9781101904237',
              'extension': 'epub'
            }));
      });
    });

    group('toString', () {
      test('returns the expected String', () {
        expect(darkMatterBook.toString(),
            equals('Book ${beautify(darkMatterBook.toJson())}'));
      });
    });

    group('hashCode', () {
      test('returns the expected String', () {
        expect(darkMatterBook.hashCode, equals(230930195));
      });
    });
  });
}
