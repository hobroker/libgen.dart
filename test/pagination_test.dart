import 'package:libgen/src/pagination.dart';
import 'package:test/test.dart';

void main() {
  group('Pagination', () {
    group('single page', () {
      test('full without offset', () {
        final nav = Pagination(25);

        expect(nav.limit, 25);
        expect(nav.page, 1);
        expect(nav.ignoreLast, isZero);
        expect(nav.ignoreFirst, isZero);
        expect(nav.hasNext, isFalse);
      });

      test('full second page', () {
        final nav = Pagination(25, offset: 25);

        expect(nav.limit, 25);
        expect(nav.page, 2);
        expect(nav.ignoreLast, isZero);
        expect(nav.ignoreFirst, isZero);
        expect(nav.hasNext, isFalse);
      });

      test('full fifth page', () {
        final nav = Pagination(5, offset: 500);

        expect(nav.limit, 25);
        expect(nav.page, 6);
        expect(nav.ignoreLast, 20);
        expect(nav.ignoreFirst, isZero);
        expect(nav.hasNext, isFalse);
      });

      test('partial page without offset', () {
        final nav = Pagination(10);

        expect(nav.limit, 25);
        expect(nav.page, 1);
        expect(nav.ignoreLast, 15);
        expect(nav.ignoreFirst, isZero);
        expect(nav.hasNext, isFalse);
      });

      test('partial page with offset', () {
        final nav = Pagination(30, offset: 5);

        expect(nav.limit, 50);
        expect(nav.page, 1);
        expect(nav.ignoreLast, 15);
        expect(nav.ignoreFirst, 5);
        expect(nav.hasNext, isFalse);
      });

      test('partial second page with offset greater than min page size', () {
        final nav = Pagination(5, offset: 30);

        expect(nav.limit, 25);
        expect(nav.page, 2);
        expect(nav.ignoreLast, 15);
        expect(nav.ignoreFirst, 5);
        expect(nav.hasNext, isFalse);
      });

      test('partial second page with offset greater than max page size', () {
        final nav = Pagination(5, offset: 100);

        expect(nav.limit, 25);
        expect(nav.page, 2);
        expect(nav.ignoreLast, 20);
        expect(nav.ignoreFirst, 0);
        expect(nav.hasNext, isFalse);
      });
    });

    group('multiple pages', () {
      test('without offset', () {
        final nav = Pagination(120);

        expect(nav.limit, 100);
        expect(nav.page, 1);
        expect(nav.ignoreFirst, 0);
        expect(nav.ignoreLast, 0);
        expect(nav.hasNext, isTrue);

        nav.next();

        expect(nav.limit, 25);
        expect(nav.page, 2);
        expect(nav.ignoreFirst, 0);
        expect(nav.ignoreLast, 5);
        expect(nav.hasNext, isFalse);
      });
    });
  });
}
