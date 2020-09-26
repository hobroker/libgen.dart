import 'package:meta/meta.dart';

class MirrorSchema {
  final bool canDownload;
  final String scheme;
  final String host;

  MirrorSchema({
    this.scheme = 'http',
    @required this.host,
    this.canDownload = false,
  }) {
    assert(host != null);
  }
}
