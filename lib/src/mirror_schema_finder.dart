import 'package:meta/meta.dart';

import 'libgen.dart';
import 'mirror_schema.dart';
import 'mirrors.dart';
import 'util.dart';

@immutable
class MirrorSchemaFinder {
  final List<MirrorSchema> _schemas;

  /// Accepts an optional list of [MirrorSchema],
  /// defaults to [mirrorSchemas]
  MirrorSchemaFinder([
    List<MirrorSchema> schemas = mirrorSchemas,
  ])  : assert(schemas.isNotEmpty),
        _schemas = schemas;

  /// Creates a [Libgen] from each [MirrorSchema] in [_schemas]
  Iterable<Libgen> _asMirrors() => _schemas
      .map((schema) => Libgen.fromSchema(schema))
      .toList(growable: false);

  /// Calls [Libgen.ping] method and
  /// returns the [Duration] that took to do this
  Future<Duration> _test(Libgen mirror) async {
    try {
      final stopwatch = Stopwatch()..start();

      await mirror.ping();

      return stopwatch.elapsed;
    } catch (e) {
      return null;
    }
  }

  /// Returns the [Libgen] with the fastest response on [Libgen.ping].
  /// Throws an [Exception] when all fail.
  Future<MirrorSchema> fastest() async {
    final futures = _asMirrors().map(_test);
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx != null) {
      return _schemas.elementAt(fastestIdx);
    }

    throw Exception('No working mirror schema');
  }

  /// Returns the first [Libgen] that has a successful reply on [Libgen.ping].
  /// Throws an [Exception] when all fail.
  Future<MirrorSchema> any() async {
    for (final schema in _schemas) {
      final mirror = Libgen.fromSchema(schema);
      if (await _test(mirror) != null) {
        return schema;
      }
    }

    throw Exception('No working mirror schema');
  }
}
