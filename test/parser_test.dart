import 'package:libgen/src/parser.dart';
import 'package:test/test.dart';

import '__mocks__/pages_mock.dart';

void main() async {
  final html = await searchPage;
  group('LibgenPageParser', () {
    test('returns the expected index', () {
      final parser = LibgenPageParser(html);

      expect(
          parser.ids,
          equals([
            2776773,
            2776772,
            2776771,
            2776770,
            2776769,
            2776768,
            2776767,
            2776766,
            2776765,
            2776764,
            2776763,
            2776762,
            2776761,
            2776760,
            2776759,
            2776758,
            2776757,
            2776756,
            2776755,
            2776754,
            2776753,
            2776752,
            2776751,
            2776750,
            2776749
          ]));
    });

    test('returns the expected .firstId', () {
      final parser = LibgenPageParser(html);

      expect(parser.firstId, equals(2776773));
    });
  });
}
