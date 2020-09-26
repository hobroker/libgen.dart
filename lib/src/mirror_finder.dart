import 'mirror.dart';
import 'mirror_schema.dart';
import 'util.dart';

class MirrorFinder {
  final List<MirrorSchema> _schemas;

  MirrorFinder(List<MirrorSchema> schemas)
      : assert(schemas.isNotEmpty),
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
  Future<LibgenMirror> fastest() async {
    final mirrors = _asMirrors();

    final futures = mirrors.map(_test);
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx == null) {
      throw Exception('No working mirror');
    }

    return mirrors.elementAt(fastestIdx);
  }

  /// Returns the first [LibgenMirror] that has a successful reply on ping()
  Future<LibgenMirror> any() async {
    for (final schema in _schemas) {
      final mirror = LibgenMirror.fromSchema(schema);
      if (await _test(mirror) != null) {
        return mirror;
      }
    }

    throw Exception('No working mirror');
  }
}
