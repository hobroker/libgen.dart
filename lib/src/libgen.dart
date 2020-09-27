import 'package:meta/meta.dart';

import 'http_client.dart';
import 'mirror_schema.dart';
import 'mirror_schema_finder.dart';
import 'models/book.dart';

@immutable
class Libgen extends _AbstactLibgen {
  final HttpClient _client;

  const Libgen({
    MirrorOptions options,
    HttpClient client,
  })  : _client = client,
        super(options: options);

  Libgen.fromSchema(MirrorSchema schema)
      : _client = HttpClient(
          host: schema.host,
          scheme: schema.scheme,
        ),
        super(options: schema.options);

  /// Returns a [Libgen] instance
  /// where [_client] is [MirrorSchema] with the shortest [ping] response
  static Future<Libgen> fastest() async {
    final schema = await MirrorSchemaFinder().fastest();
    return Libgen.fromSchema(schema);
  }

  /// Returns a [Libgen] instance
  /// where [_client] is [MirrorSchema] with a successful [ping] response
  static Future<Libgen> any() async {
    final schema = await MirrorSchemaFinder().any();
    return Libgen.fromSchema(schema);
  }

  /// Retuns a [List] of [Map] with [fields] by [ids]
  @override
  Future<Book> getById(String id) => _client.request('json.php', query: {
        'ids': id,
        'fields': '*',
      }).then((results) =>
          results.isNotEmpty ? Book.fromJson(results.first) : null);

  /// Returns `"pong"` if the mirror returned any data
  ///
  /// Throws an [Exception] if the request fails
  @override
  Future<String> ping() => getById('1').then((e) => 'pong');
}

@immutable
abstract class _AbstactLibgen {
  final MirrorOptions _options;

  const _AbstactLibgen({
    MirrorOptions options,
  }) : _options = options;

  /// Returns the internal [_options.canDownload].
  bool get canDownload => _options.canDownload;

  Future<Book> getById(String id);

  Future<String> ping();
}
