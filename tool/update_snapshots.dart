import 'dart:io';

import 'package:http/http.dart' as http;

final getBody = (http.Response response) => response.body;

final basePath = 'test/__snapshots__';

final requests = {
  'search-latest-page.html': Request(
    path: 'search.php',
    query: {'mode': 'last'},
    transform: getBody,
  ),
};

void main() async {
  try {
    await File(basePath).create(recursive: true);
  } catch (e) {
    //
  }

  for (final request in requests.entries) {
    final uri = Uri(
      scheme: 'http',
      host: 'libgen.rs',
      path: request.value.path,
      queryParameters: request.value.query,
    );
    final response = await http.get(uri);
    final data = request.value.transform(response);

    await File('$basePath/${request.key}').writeAsString(data);
  }
}

class Request {
  final String path;
  final Map<String, String> query;
  final String Function(http.Response) transform;

  Request({this.path, this.query, this.transform});
}
