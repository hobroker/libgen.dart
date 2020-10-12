import 'dart:convert';

import 'package:http/http.dart' show Client, Response;
import 'package:mockito/mockito.dart';

// import 'package:test/test.dart';
class MockClient extends Mock implements Client {}

MockClient mockedClientWithRespoonse(dynamic response, [int statusCode = 200]) {
  final client = MockClient();
  when(client.get(any)).thenAnswer((_) async {
    final string =
        response is String ? response : JsonEncoder().convert(response);

    return Response(string, statusCode);
  });

  return client;
}
