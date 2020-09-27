import 'http_client.dart';
import 'mirror_schema.dart';
import 'mirror_schema_finder.dart';

class LibgenMirror {
  final bool _canDownload;

  final HttpClient _http;

  LibgenMirror({
    bool canDownload = false,
    HttpClient client,
  })  : _http = client,
        _canDownload = canDownload;

  bool get canDownload => _canDownload;

  factory LibgenMirror.fromSchema(MirrorSchema schema) => LibgenMirror(
        canDownload: schema.canDownload,
        client: HttpClient(
          host: schema.host,
          scheme: schema.scheme,
        ),
      );

  /// Returns a [LibgenMirror] instance
  /// [_http] with the first [MirrorSchema] which has the shortest response
  static Future<LibgenMirror> fastest() async {
    final schema = await MirrorSchemaFinder().fastest();
    return LibgenMirror.fromSchema(schema);
  }

  /// Returns a [LibgenMirror] instance
  /// [_http]  with the first [MirrorSchema] which has a successful response
  static Future<LibgenMirror> any() async {
    final schema = await MirrorSchemaFinder().any();
    return LibgenMirror.fromSchema(schema);
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
