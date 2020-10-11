import 'dart:async';

import 'package:http/http.dart' show Client;
import 'package:meta/meta.dart';

import 'constants.dart';
import 'http_client.dart';

@immutable
class LibgenApi extends HttpClient {
  LibgenApi({
    Uri baseUri,
    Client client,
  }) : super(
          baseUri: baseUri,
          client: client,
        );

  /// Requests /json.php with [ids] and [searchFields]
  Future<List> json(List ids) => request<List>('json.php', query: {
        'ids': ids.join(','),
        'fields': searchFields,
      });

  /// Requests /search.php with [query]
  Future<String> search(Map<String, String> query) =>
      requestRaw('search.php', query: query);
}
