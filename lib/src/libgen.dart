import 'package:libgen/src/mirror.dart';
import 'package:libgen/src/mirror_finder.dart';
import 'package:libgen/src/mirror_schema.dart';
import 'package:libgen/src/mirrors.dart';

class Libgen {
  LibgenMirror mirror;

  Libgen({this.mirror}) {
    mirror ??= LibgenMirror.fromSchema(defaultMirror);
  }

  /// Sets [mirror] to one of [schemas]'s [LibgenMirror]
  /// which has the shortest response
  Future setFastestMirror() async {
    mirror = await MirrorFinder(schemas).fastest();
  }

  /// Sets [mirror] to the first [LibgenMirror] which has a successful response
  Future setAnyMirror() async {
    mirror = await MirrorFinder(schemas).any();
  }

  /// The list of default [MirrorSchema]
  static final schemas = libgenMirrorSchemas;
}
