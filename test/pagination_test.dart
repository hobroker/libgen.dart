import 'package:libgen/src/pagination.dart';
import 'package:test/test.dart';

void main() {
  group('Pagination', () {
    group('single page', () {
      test('full without offset', () {
        final pagination = Pagination(25);

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(1));
        expect(pagination.ignoreLast, isZero);
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.hasNext, isFalse);
      });

      test('full second page', () {
        final pagination = Pagination(25, offset: 25);

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(2));
        expect(pagination.ignoreLast, isZero);
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.hasNext, isFalse);
      });

      test('full fifth page', () {
        final pagination = Pagination(5, offset: 500);

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(6));
        expect(pagination.ignoreLast, 20);
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.hasNext, isFalse);
      });

      test('partial page without offset', () {
        final pagination = Pagination(10);

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(1));
        expect(pagination.ignoreLast, equals(15));
        expect(pagination.ignoreFirst, isZero);
        expect(pagination.hasNext, isFalse);
      });

      test('partial page with offset', () {
        final pagination = Pagination(30, offset: 5);

        expect(pagination.limit, equals(50));
        expect(pagination.page, equals(1));
        expect(pagination.ignoreLast, equals(15));
        expect(pagination.ignoreFirst, equals(5));
        expect(pagination.hasNext, isFalse);
      });

      test('partial second page with offset greater than min page size', () {
        final pagination = Pagination(5, offset: 30);

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(2));
        expect(pagination.ignoreLast, equals(15));
        expect(pagination.ignoreFirst, equals(5));
        expect(pagination.hasNext, isFalse);
      });

      test('partial second page with offset greater than max page size', () {
        final pagination = Pagination(5, offset: 100);

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(2));
        expect(pagination.ignoreLast, equals(20));
        expect(pagination.ignoreFirst, equals(0));
        expect(pagination.hasNext, isFalse);
      });
    });

    group('multiple pages', () {
      test('without offset', () {
        final pagination = Pagination(120);

        expect(pagination.limit, equals(100));
        expect(pagination.page, equals(1));
        expect(pagination.ignoreFirst, equals(0));
        expect(pagination.ignoreLast, equals(0));
        expect(pagination.hasNext, isTrue);

        pagination.next();

        expect(pagination.limit, equals(25));
        expect(pagination.page, equals(2));
        expect(pagination.ignoreFirst, equals(0));
        expect(pagination.ignoreLast, equals(5));
        expect(pagination.hasNext, isFalse);
      });
    });
  });
}
