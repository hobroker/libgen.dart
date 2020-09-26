import 'mirror.dart';
import 'mirror_finder.dart';
import 'mirrors.dart';

class Libgen {
  LibgenMirror _mirror;

  Libgen({LibgenMirror mirror}) {
    _mirror ??= LibgenMirror.fromSchema(defaultMirror);
  }

  /// Sets [_mirror] to one of [schemas]'s [LibgenMirror]
  /// which has the shortest response
  Future setFastestMirror() async {
    _mirror = await MirrorFinder(schemas).fastest();
  }

  /// Sets [_mirror] to the first [LibgenMirror] which has a successful response
  Future setAnyMirror() async {
    _mirror = await MirrorFinder(schemas).any();
  }

  /// The list of default [MirrorSchema]
  static final schemas = libgenMirrorSchemas;

  Future<List> getByIds(List<int> ids, [String fields = '*']) =>
      _mirror.getByIds(ids, fields);
}
