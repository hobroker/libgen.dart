import 'mirror_schema.dart';

const List<MirrorSchema> mirrorSchemas = [
  MirrorSchema(
    host: 'libgen.is',
    canDownload: true,
  ),
  MirrorSchema(
    host: 'gen.lib.rus.ec',
  ),
];

final defaultMirror = mirrorSchemas.first;
