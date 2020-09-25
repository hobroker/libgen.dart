import 'package:libgen/src/http_client.dart';

abstract class LibgenMirror {
  String get host;

  UrlSchema get schema;

  bool get canDownload => false;

  HttpClient _http;

  LibgenMirror({HttpClient http}) : _http = http {
    _http ??= HttpClient(host: host, schema: schema);
  }

  Future<List> getByIds(List<int> ids, [String fields = '*']) =>
      _http.request('json.php', query: {
        'ids': ids.join(','),
        'fields': fields,
      });

  Future<String> ping() => getByIds([1]).then((e) => 'pong');
}
