import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/mirror.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockedHttpClient extends Mock implements HttpClient {}

class _LibgenMirror extends LibgenMirror {
  @override
  String get host => 'example.com';

  @override
  UrlSchema get schema => UrlSchema.https;

  _LibgenMirror({HttpClient http}) : super(http: http);
}

void main() {
  group('LibgenMirror', () {
    _LibgenMirror withGetById(response, query) {
      final http = MockedHttpClient();
      final mirror = _LibgenMirror(http: http);

      return mirror;
    }

    group('getByIds', () {
      test('returns a list of objects', () async {
        final response = [
          {'id': '1'}
        ];
        final mirror = withGetById(response, {'ids': '1', 'fields': '*'});
        final result = await mirror.getByIds([1]);

        expect(result, equals(response));
      });

      test('returns an empty list', () async {
        final response = [];
        final mirror = withGetById(response, {'ids': '999999', 'fields': '*'});
        final result = await mirror.getByIds([999999]);

        expect(result, equals(response));
      });
    });

    group('ping', () {
      test('returns pong on success', () async {
        final mirror = withGetById([], {'ids': '1', 'fields': '*'});
        final result = await mirror.ping();

        expect(result, equals('pong'));
      });

      test('throws an error on error', () async {
        final exception = Exception();
        final response = Future.value(null).then((value) => throw exception);

        final mirror = withGetById(response, {'ids': '1', 'fields': '*'});
        await mirror.ping().catchError((error) {
          expect(error, equals(exception));
        });
      });
    });

    group('canDownload', () {
      test('returns false', () async {
        final http = MockedHttpClient();
        final mirror = _LibgenMirror(http: http);

        expect(mirror.canDownload, equals(false));
      });
    });
  });
}
