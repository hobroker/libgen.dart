import 'package:libgen/src/util.dart';
import 'package:test/test.dart';

void main() {
  group('minNonNullIndex', () {
    test('returns the expected index', () async {
      expect(minNonNullIndex([1, 2, 3]), equals(0));
      expect(minNonNullIndex([2, 1, 3]), equals(1));
      expect(minNonNullIndex([2, null, 3]), equals(0));
    });

    test('returns null', () async {
      expect(minNonNullIndex([]), equals(null));
      expect(minNonNullIndex([null, null]), equals(null));
    });
  });
}
