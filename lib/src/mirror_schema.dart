import 'package:meta/meta.dart';

@immutable
class MirrorSchema {
  final String scheme;
  final String host;
  final MirrorOptions options;

  Uri get uri => Uri(scheme: scheme, host: host);

  const MirrorSchema({
    @required this.host,
    this.scheme = 'http',
    this.options = const MirrorOptions(),
  }) : assert(scheme == 'http' || scheme == 'https');
}

@immutable
class MirrorOptions {
  final bool canDownload;

  const MirrorOptions({
    this.canDownload = false,
  });
}
