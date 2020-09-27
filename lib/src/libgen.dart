import 'package:meta/meta.dart';
import 'http_client.dart';
import 'mirror_schema.dart';
import 'mirror_schema_finder.dart';

@immutable
class Libgen {
  final MirrorOptions _options;

  final HttpClient _http;

  Libgen({
    MirrorOptions options,
    HttpClient client,
  })  : _http = client,
        _options = options;

  /// Returns the internal [_options.canDownload].
  bool get canDownload => _options.canDownload;

  factory Libgen.fromSchema(MirrorSchema schema) => Libgen(
        options: schema.options,
        client: HttpClient(
          host: schema.host,
          scheme: schema.scheme,
        ),
      );

  /// Returns a [Libgen] instance
  /// [_http] is [MirrorSchema] with the shortest [ping] response
  static Future<Libgen> fastest() async {
    final schema = await MirrorSchemaFinder().fastest();
    return Libgen.fromSchema(schema);
  }

  /// Returns a [Libgen] instance
  /// [_http] is [MirrorSchema] with a successful [ping] response
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
