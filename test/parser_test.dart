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
            62088,
            162642,
            254180,
            254300,
            257758,
            258369,
            273947,
            262824,
            262826,
            264371,
            264495,
            269781,
            343251,
            357371,
            387719,
            389057,
            389425,
            391527,
            391961,
            396417,
            406729,
            416043,
            422491,
            429205,
            430596
          ]));
    });

    test('returns the expected .firstId', () {
      final parser = LibgenPageParser(html);

      expect(parser.firstId, equals(62088));
    });
  });
}
