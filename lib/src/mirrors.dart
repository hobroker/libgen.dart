import 'package:libgen/src/mirror_schema.dart';

final libgenMirrorSchemas = [
  MirrorSchema(
    host: 'libgen.is',
    canDownload: true,
  ),
  MirrorSchema(
    host: 'gen.lib.rus.ec',
  ),
];

final defaultMirror = libgenMirrorSchemas.first;
