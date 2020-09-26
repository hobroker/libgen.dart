import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  final http.Client _httpClient;
  final Uri baseUri;

  HttpClient({this.baseUri, http.Client client})
      : _httpClient = client ?? http.Client();

  bool get _isHttps => baseUri?.isScheme('https') ?? false;

  String get _host => baseUri?.host;

  Uri _makeUrl(String path, Map<String, String> query) =>
      _isHttps ? Uri.https(_host, path, query) : Uri.http(_host, path, query);

  Future<T> request<T>(
    path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final url = _makeUrl(path, query);
    final response = await get(url, headers: headers);
    if (response.statusCode != 200) {
      throw response;
    }

    final body = response.body;

    if (body == null || body.isEmpty) {
      return null;
    }

    return json.decode(body);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _httpClient.send(request);
}
