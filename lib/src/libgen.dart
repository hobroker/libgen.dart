import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirrors.dart';

class Libgen {
  LibgenMirror mirror;

  Libgen({this.mirror}) {
    mirror ??= LibgenMirror.fromSchema(defaultMirror);
  }

  void setFastestMirror() async {
    final fastest = await MirrorSchemaFinder(schemas).fastest();

    mirror = LibgenMirror.fromSchema(fastest);
  }

  static final schemas = libgenMirrorSchemas;
}
