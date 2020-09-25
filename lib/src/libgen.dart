import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirrors.dart';

class Libgen {
  LibgenMirror mirror;

  Libgen({this.mirror}) {
    mirror ??= LibgenIsMirror();
  }

  List<LibgenMirror> get _mirrors => [
        GenLibRusEcMirror(),
        LibgenIsMirror(),
      ];

  void setFastestMirror() async =>
      mirror = await LibgenMirrorFinder(_mirrors).fastest();
}
