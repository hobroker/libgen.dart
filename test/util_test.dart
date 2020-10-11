import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

void main() {
  group('minNonNullIndex', () {
    test('returns the expected index', () async {
      expect(minNonNullIndex([1, 2, 3]), 0);
      expect(minNonNullIndex([2, 1, 3]), 1);
      expect(minNonNullIndex([2, null, 3]), 0);
    });

    test('returns null', () async {
      expect(minNonNullIndex([]), isNull);
      expect(minNonNullIndex([null, null]), isNull);
    });
  });

  group('beautify', () {
    test('returns the expected String', () {
      expect(beautify(null), 'null');
      expect(beautify({}), '{}');
      expect(beautify({'id': 1, 'title': 'zxc'}), '''{
  "id": 1,
  "title": "zxc"
}''');
    });

    test('returns [null] on null input', () {
      expect(beautify(null), 'null');
    });
  });

  group('getResultsCount', () {
    test('returns the expected int', () {
      expect(getResultsCount(10), 25);
      expect(getResultsCount(5), 25);
      expect(getResultsCount(25), 25);
      expect(getResultsCount(30), 50);
      expect(getResultsCount(50), 50);
      expect(getResultsCount(70), 100);
      expect(getResultsCount(100), 100);
      expect(getResultsCount(120), 100);
    });
  });
}
