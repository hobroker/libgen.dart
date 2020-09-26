import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/util.dart';

class MirrorSchemaFinder {
  final List<MirrorSchema> schemas;

  MirrorSchemaFinder(this.schemas);

  /// Calls [LibgenMirror] ping() method and
  /// returns the [Duration] that took to do this
  Future<Duration> _test(MirrorSchema mirror) async {
    try {
      final stopwatch = Stopwatch()..start();

      await LibgenMirror.fromSchema(mirror).ping();

      return stopwatch.elapsed;
    } catch (e) {
      return null;
    }
  }

  /// Calls every [MirrorSchema] ping() method and
  /// returns the [MirrorSchema] which replied the fastest
  Future<MirrorSchema> fastest() async {
    if (schemas.length == 1) {
      return schemas.first;
    }

    final futures = schemas.map((mirror) => _test(mirror));
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    if (fastestIdx == null) {
      throw Exception('No working mirror');
    }

    return schemas[fastestIdx];
  }

  /// Returns the first [LibgenMirror] that has a successful reply
  Future<MirrorSchema> any() async {
    if (schemas.length == 1) {
      return schemas.first;
    }

    for (final mirror in schemas) {
      try {
        await LibgenMirror.fromSchema(mirror).ping();

        return mirror;
      } catch (e) {
        continue;
      }
    }

    throw Exception('No working mirror');
  }
}
