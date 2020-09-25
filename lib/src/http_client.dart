import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

final _startSlashesMatcher = RegExp('^[\\\/]{1,}');

enum UrlSchema { http, https }

class HttpClient extends BaseClient {
  final _httpClient = Client();
  final String host;
  final UrlSchema schema;

  HttpClient({this.host, this.schema});

  String _makeUrl(String path, Map<String, String> query) {
    final _path = path.replaceFirst(_startSlashesMatcher, '');

    return query == null
        ? '$schema$host/$_path'
        : (schema == UrlSchema.https
                ? Uri.https(host, _path, query)
                : Uri.http(host, _path, query))
            .toString();
  }

  Future<T> request<T>(
    path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final url = _makeUrl(path, query);
    final response = await get(url, headers: headers);
    final body = response.body;

    return json.decode(body);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      _httpClient.send(request);
}
