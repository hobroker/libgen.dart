import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';
import '__mocks__/schema_mock.dart';
import 'utils.dart';

// ignore: must_be_immutable
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('Libgen', () {
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
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.getById('1591104');

        expect(result, equals(darkMatterBook.object));
      });

      test('returns null on no results', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.getById('missing');

        expect(result, equals(null));
      });
    });

    group('.getByIds()', () {
      test('returns the expected list of books', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final expected = {
          '1': firstBook.object,
          '1591104': darkMatterBook.object,
        };
        final result = await mirror.getByIds(List<String>.from(expected.keys));

        expect(result, equals(expected.values));
      });

      test('returns empty array on no results', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.getByIds(['missing']);

        expect(result, equals([]));
      });
    });

    group('.ping()', () {
      test('returns pong on success', () async {
        final mirror = Libgen(client: defaultMockedClient());
        final result = await mirror.ping();

        expect(result, equals('pong'));
      });
    });

    group('.canDownload', () {
      test('returns false when `options` are missing', () async {
        final mirror = Libgen(client: defaultMockedClient());

        expect(mirror.canDownload, equals(false));
      });

      test('returns the expected value', () async {
        expect(
          Libgen(
            client: defaultMockedClient(),
            options: MirrorOptions(canDownload: false),
          ).canDownload,
          equals(false),
        );
        expect(
          Libgen(
            client: defaultMockedClient(),
            options: MirrorOptions(canDownload: true),
          ).canDownload,
          equals(true),
        );
      });
    });
  });
}
