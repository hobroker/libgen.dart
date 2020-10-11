import 'dart:async';

import 'package:http/http.dart' hide get;
import 'package:meta/meta.dart';

import 'exceptions.dart';

@immutable
class HttpClient {
  final Client client;
  final Uri baseUri;

  HttpClient({
    this.baseUri,
    Client client,
  }) : client = client ?? Client();

  /// Sends an HTTP GET request to [baseUri] with the
  /// required [path] and optional [query] and [headers]
  Future<String> get(
    String path, [
    Map<String, String> query,
  ]) async {
    final url = baseUri?.replace(path: path, queryParameters: query);
    final response = await client.get(url);
    if (response.statusCode != 200) {
      throw HttpException(response);
    }

    final body = response.body;

    if (body == null || body.isEmpty) {
      return null;
    }

    return body;
  }
}
