import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_schema_finder.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';

// ignore: must_be_immutable
class MockLibgen extends Mock implements Libgen {}

void main() {
  group('MirrorSchemaFinder', () {
    group('.fastest()', () {
      test('returns the expected Libgen instance', () async {
        final workingMirror = MockLibgen();
        final brokenMirror = MockLibgen();
        final list = [workingMirror, brokenMirror];

        when(workingMirror.ping())
            .thenAnswer((_) async => darkMatterBook.toString());

        when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());

        var mirror = await MirrorSchemaFinder(list).fastest();

        expect(mirror, equals(workingMirror));
      });
    });

    // verifyZeroInteractions(cat);

    group('.any()', () {
      test('returns the expected Libgen instance', () async {
        final workingMirror = MockLibgen();
        final brokenMirror = MockLibgen();
        final list = [brokenMirror, workingMirror];

        when(workingMirror.ping())
            .thenAnswer((_) async => darkMatterBook.toString());

        when(brokenMirror.ping()).thenAnswer((_) async => throw Exception());

        var mirror = await MirrorSchemaFinder(list).any();

        expect(mirror, equals(workingMirror));
      });

      test('does not call the other mirror once it finds one', () async {
        final workingMirror = MockLibgen();
        final brokenMirror = MockLibgen();
        final list = [workingMirror, brokenMirror];

        when(workingMirror.ping())
            .thenAnswer((_) async => darkMatterBook.toString());

        verifyZeroInteractions(brokenMirror);

        var mirror = await MirrorSchemaFinder(list).any();

        expect(mirror, equals(workingMirror));
      });
    });
  });
}
