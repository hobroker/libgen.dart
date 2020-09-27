import 'http_client.dart';
import 'mirror_schema.dart';
import 'mirror_schema_finder.dart';

class Libgen {
  final bool _canDownload;

  final HttpClient _http;

  Libgen({
    bool canDownload = false,
    HttpClient client,
  })  : _http = client,
        _canDownload = canDownload;

  bool get canDownload => _canDownload;

  factory Libgen.fromSchema(MirrorSchema schema) => Libgen(
        canDownload: schema.canDownload,
        client: HttpClient(
          host: schema.host,
          scheme: schema.scheme,
        ),
      );

  /// Returns a [Libgen] instance
  /// [_http] with the first [MirrorSchema] which has the shortest response
  static Future<Libgen> fastest() async {
    final schema = await MirrorSchemaFinder().fastest();
    return Libgen.fromSchema(schema);
  }

  /// Returns a [Libgen] instance
  /// [_http]  with the first [MirrorSchema] which has a successful response
  static Future<Libgen> any() async {
    final schema = await MirrorSchemaFinder().any();
    return Libgen.fromSchema(schema);
  }

  /// Retuns a [List] of [Map] with [fields] by [ids]
  Future<List> getByIds(List<int> ids, [String fields = '*']) =>
      _http.request('json.php', query: {
        'ids': ids.join(','),
        'fields': fields,
      });

  /// Returns `"pong"` if the mirror returned any data
  ///
  /// Throws an [Exception] if the request fails
  Future<String> ping() => getByIds([1]).then((e) => 'pong');
}
