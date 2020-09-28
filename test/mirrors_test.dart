import 'package:libgen/src/libgen.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/mirrors.dart';
import 'package:test/test.dart';

import '__mocks__/book_mock.dart';

void main() {
  group('mirror', () {
    void testSchema(MirrorSchema schema) {
      group(schema.baseUri, () {
        final mirror = Libgen.fromSchema(schema);

        test('returns "pong" on [ping]', () async {
          expect(await mirror.ping(), equals('pong'));
        });

        test('returns the expected Book', () async {
          expect(await mirror.getById(darkMatterBook.id),
              equals(darkMatterBook.object));
        });
      });
    }

    for (final schema in mirrorSchemas) {
      testSchema(schema);
    }
  });
}
