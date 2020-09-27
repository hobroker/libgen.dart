import 'mirror.dart';
import 'mirror_schema.dart';
import 'mirrors.dart';
import 'util.dart';

class MirrorSchemaFinder {
  final List<MirrorSchema> _schemas;

  /// Accepts an optional list of [MirrorSchema],
  /// defaults to [mirrorSchemas]
  MirrorSchemaFinder([
    List<MirrorSchema> schemas = mirrorSchemas,
  ])  : assert(schemas.isNotEmpty),
        _schemas = schemas;

  /// Creates a [LibgenMirror] from each [MirrorSchema] in [_schemas]
  Iterable<LibgenMirror> _asMirrors() => _schemas
      .map((schema) => LibgenMirror.fromSchema(schema))
      .toList(growable: false);

  /// Calls [LibgenMirror] ping() method and
  /// returns the [Duration] that took to do this
  Future<Duration> _test(LibgenMirror mirror) async {
    try {
      final stopwatch = Stopwatch()..start();

      await mirror.ping();

      return stopwatch.elapsed;
    } catch (e) {
      return null;
    }
  }

  /// Calls every [LibgenMirror] ping() method and
  /// returns the [LibgenMirror] which replied the fastest
  Future<MirrorSchema> fastest() async {
    final futures = _asMirrors().map(_test);
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx == null) {
      throw Exception('No working mirror schema');
    }

    return _schemas.elementAt(fastestIdx);
  }

  /// Returns the first [LibgenMirror] that has a successful reply on ping().
  /// Throws an [Exception] when there all calls failed
  Future<MirrorSchema> any() async {
    for (final schema in _schemas) {
      final mirror = LibgenMirror.fromSchema(schema);
      if (await _test(mirror) != null) {
        return schema;
      }
    }

    throw Exception('No working mirror schema');
  }
}
