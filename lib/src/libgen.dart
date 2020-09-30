import 'package:meta/meta.dart';

import 'http_client.dart';
import 'mirror_finder.dart';
import 'mirror_schema.dart';
import 'mirrors.dart';
import 'models/book.dart';

@immutable
class Libgen extends _AbstactLibgen {
  final HttpClient _client;

  const Libgen({
    @required HttpClient client,
    MirrorOptions options = const MirrorOptions(),
  })  : _client = client,
        super(options: options);

  Libgen.fromSchema(MirrorSchema schema)
      : _client = HttpClient(baseUri: schema.baseUri),
        super(options: schema.options);

  static MirrorFinder get finder => MirrorFinder.fromSchemas(mirrorSchemas);

  /// Returns a [Libgen] instance
  /// with [_client] being [MirrorSchema] with THE SHORTEST [ping] response
  static Future<Libgen> fastest() => finder.fastest();

  /// Returns a [Libgen] instance
  /// with [_client] being [MirrorSchema] with ANY SUCCESSFUL [ping] response
  static Future<Libgen> any() => finder.any();

  /// Returns a [Book] by [id]
  /// Returns [Null] on no result
  @override
  Future<Book> getById(int id) async {
    final results = await getByIds([id]);

    if (results.isEmpty == true) {
      return null;
    }

    return results.first;
  }

  /// Returns a [List] of [Book] by [ids]
  @override
  Future<List<Book>> getByIds(List<int> ids) async {
    final results = await _client.request<List>('json.php',
        query: {'ids': ids.join(','), 'fields': '*'});

    return results.map<Book>((item) => Book.fromJson(item)).toList();
  }

  /// Returns `"pong"` if the request succeeds
  ///
  /// Returns [Exception] if the request fails
  @override
  Future<String> ping() => getById(1).then((e) => 'pong');
}

@immutable
abstract class _AbstactLibgen {
  final MirrorOptions _options;

  const _AbstactLibgen({
    MirrorOptions options,
  }) : _options = options;

  /// Returns the internal [_options.canDownload].
  bool get canDownload => _options.canDownload;

  Future<Book> getById(int id);

  Future<List<Book>> getByIds(List<int> id);

  Future<String> ping();
}
