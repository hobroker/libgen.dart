import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/mirror.dart';

class GenLibRusEcMirror extends LibgenMirror {
  @override
  UrlSchema get schema => UrlSchema.http;

  @override
  String get host => 'gen.lib.rus.ec';
}

class LibgenIsMirror extends LibgenMirror {
  @override
  UrlSchema get schema => UrlSchema.http;

  @override
  String get host => 'libgen.is';

  @override
  bool get canDownload => true;
}
