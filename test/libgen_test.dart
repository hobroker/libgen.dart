import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import '__mocks__/schema_mock.dart';

// ignore: must_be_immutable
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('Libgen', () {
    final client = MockHttpClient();
    when(client.request('json.php', query: {
      'ids': '1591104',
      'fields': '*',
    })).thenAnswer((_) async => singleJsonList);
    when(client.request('json.php', query: {
      'ids': '0',
      'fields': '*',
    })).thenAnswer((_) async => []);

    final mockedLibgenMirror = ({bool canDownload = false}) => Libgen(
        client: client, options: MirrorOptions(canDownload: canDownload));

    group('.fromSchema()', () {
      test('creates a new `Libgen` from `MirrorSchema', () async {
        final mirror = Libgen.fromSchema(workingSchemaSample);

        expect(mirror is Libgen, equals(true));
      });
    });

    group('.finder', () {
      test('returns a `MirrorFinder` instance', () async {
        expect(Libgen.finder is MirrorFinder, equals(true));
      });
    });

    group('.fastest', () {
      test('returns a `Libgen` instance', () async {
        expect(await Libgen.fastest() is Libgen, equals(true));
      });
    });

    group('.any', () {
      test('returns a `Libgen` instance', () async {
        expect(await Libgen.any() is Libgen, equals(true));
      });
    });

    group('.getById()', () {
      test('returns the expected `Book`', () async {
        final mirror = mockedLibgenMirror();
        final result = await mirror.getById('1591104');

        expect(result, equals(darkMatterBook.object));
      });

      test('returns null on no results', () async {
        final mirror = mockedLibgenMirror();
        final result = await mirror.getById('0');

        expect(result, equals(null));
      });
    });

    group('.ping()', () {
      test('returns pong on success', () async {
        final mirror = mockedLibgenMirror();
        final result = await mirror.ping();

        expect(result, equals('pong'));
      });
    });

    group('.canDownload', () {
      test('returns false when `options` are missing', () async {
        final mirror = Libgen(client: client);

        expect(mirror.canDownload, equals(false));
      });

      test('returns the expected value', () async {
        expect(mockedLibgenMirror().canDownload, equals(false));
        expect(
            mockedLibgenMirror(canDownload: false).canDownload, equals(false));
        expect(mockedLibgenMirror(canDownload: true).canDownload, equals(true));
      });
    });
  });
}
