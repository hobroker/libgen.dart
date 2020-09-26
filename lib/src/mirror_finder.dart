import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/util.dart';

class MirrorFinder {
  final List<MirrorSchema> schemas;

  MirrorFinder(this.schemas);

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
    if (schemas.isEmpty) {
      return null;
    }
    final mirrors = schemas.map((schema) => LibgenMirror.fromSchema(schema));

    if (schemas.length == 1) {
      return mirrors.first;
    }

    final futures = mirrors.map((mirror) => _test(mirror));
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx == null) {
      throw Exception('No working mirror');
    }

    return mirrors.elementAt(fastestIdx);
  }

  /// Returns the first [LibgenMirror] that has a successful reply on ping()
  Future<LibgenMirror> any() async {
    if (schemas.length == 1) {
      return LibgenMirror.fromSchema(schemas.first);
    }

    for (final schema in schemas) {
      final mirror = LibgenMirror.fromSchema(schema);
      if (await _test(mirror) != null) {
        return mirror;
      }
    }

    throw Exception('No working mirror');
  }
}
