import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:meta/meta.dart';

import '../libgen.dart';
import 'constants.dart';
import 'http_client.dart';

@immutable
class LibgenApi extends HttpClient {
  LibgenApi({
    Uri baseUri,
    Client client,
  }) : super(baseUri: baseUri, client: client);

  LibgenApi.fromSchema(MirrorSchema schema) : super(baseUri: schema.baseUri);

  /// Requests /json.php with [ids] and [searchFields]
  Future<List> json(List ids) async {
    final body = await get('json.php', {
      'ids': ids.join(','),
      'fields': searchFields,
    });

    if (body == null) {
      return null;
    }

    return JsonDecoder().convert(body);
  }

  /// Requests /search.php with [query]
  Future<String> search(Map<String, String> query) => get('search.php', query);
}
