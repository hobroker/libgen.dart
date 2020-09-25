import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/util.dart';

class LibgenMirrorFinder {
  final List<LibgenMirror> mirrors;

  LibgenMirrorFinder(this.mirrors);

  Future<Duration> _test(LibgenMirror mirror) async {
    try {
      final stopwatch = Stopwatch()..start();

      await mirror.ping();

      return stopwatch.elapsed;
    } catch (e) {
      return null;
    }
  }

  Future<LibgenMirror> fastest() async {
    if (mirrors.length == 1) {
      return mirrors.first;
    }

    final futures = mirrors.map((mirror) => _test(mirror));
    final results = await Future.wait(futures);
    final fastestIdx = minNonNullIndex(results);

    return mirrors[fastestIdx];
  }
}
