import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' hide get;
import 'package:meta/meta.dart';

import 'constants.dart';
import 'exceptions.dart';
import 'page_parser.dart';

@immutable
class HttpClient extends BaseClient with _LibgenApi {
  final Client _httpClient;
  final Uri baseUri;

  HttpClient({
    this.baseUri,
    Client client,
  }) : _httpClient = client ?? Client();

  /// Sends an HTTP GET request to [baseUri] with the
  /// required [path] and optional [query] and [headers]
  Future<T> _request<T>(
    String path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final body = await _requestRaw(path, query: query, headers: headers);

    return JsonDecoder().convert(body);
  }

  /// Sends an HTTP GET request to [baseUri] with the
  /// required [path] and optional [query] and [headers]
  Future<String> _requestRaw(
    String path, {
    Map<String, String> query,
    Map<String, String> headers,
  }) async {
    final url = baseUri?.replace(path: path, queryParameters: query);
    final response = await get(url, headers: headers);
    if (response.statusCode != 200) {
      throw HttpException(response);
    }

    final body = response.body;

    if (body == null || body.isEmpty) {
      return null;
    }

    return body;
  }

  /// Sends an HTTP request and asynchronously returns the response.
  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      _httpClient.send(request);

  /// Requests /json.php with [ids] and [searchFields]
  @override
  Future<List> json(List ids) => _request<List>('json.php', query: {
        'ids': ids.join(','),
        'fields': searchFields,
      });

  /// Requests /search.php with [query]
  @override
  Future<PageParser> search(Map<String, String> query) async {
    final body = await _requestRaw('search.php', query: query);
    return PageParser(body);
  }
}

abstract class _LibgenApi {
  Future<List> json(List ids);

  Future<PageParser> search(Map<String, String> query);
}
