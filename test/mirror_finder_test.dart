import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_schema_finder.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';

// ignore: must_be_immutable
class MockLibgen extends Mock implements Libgen {}

void main() {
  group('MirrorSchemaFinder', () {
    final workingMirror = MockLibgen();
    final brokenMirror = MockLibgen();
    final list = [workingMirror, brokenMirror];
    final _reset = () {
      reset(workingMirror);
      reset(brokenMirror);
    };

    group('.fastest()', () {
      final finder = MirrorSchemaFinder(list);
      setUp(_reset);

      test('returns the expected `Libgen` instance', () async {
        when(workingMirror.ping())
            .thenAnswer((_) async => darkMatterBook.toString());

        when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());

        expect(await finder.fastest(), equals(workingMirror));
      });

      test('throws an `Exception` when all mirrros throw', () async {
        when(workingMirror.ping()).thenAnswer((_) async => throw Exception());

        when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());

        try {
          await finder.fastest();
          assert(false);
        } catch (e) {
          expect(e is Exception, equals(true));
        }
      });
    });

    group('.any()', () {
      final finder = MirrorSchemaFinder(list);
      setUp(_reset);

      test('returns the expected Libgen instance', () async {
        when(workingMirror.ping())
            .thenAnswer((_) async => darkMatterBook.toString());

        when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());

        expect(await finder.any(), equals(workingMirror));
      });

      test('does not call the other mirror once it finds one', () async {
        when(workingMirror.ping())
            .thenAnswer((_) async => darkMatterBook.toString());

        verifyZeroInteractions(brokenMirror);

        expect(await finder.any(), equals(workingMirror));
      });

      test('throws an `Exception` when all mirrros throw', () async {
        when(workingMirror.ping()).thenAnswer((_) async => throw Exception());

        when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());

        try {
          await finder.any();
          assert(false);
        } catch (e) {
          expect(e is Exception, equals(true));
        }
      });
    });
  });
}
