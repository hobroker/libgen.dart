import 'package:libgen/src/http_client.dart';

class LibgenMirror {
  final bool canDownload;

  final HttpClient _http;

  LibgenMirror({
    this.canDownload = false,
    HttpClient client,
  }) : _http = client;

  LibgenMirror.fromSchema(Map<String, dynamic> schema)
      : canDownload = schema['canDownload'],
        _http = HttpClient(baseUri: schema['uri']);

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
