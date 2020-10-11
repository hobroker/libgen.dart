import 'dart:io';

import 'package:libgen/src/http_client.dart';
import 'package:libgen/src/libgen_api.dart';
import 'package:mockito/mockito.dart';

import '__mocks__/book_mock.dart';

// ignore: must_be_immutable
class MockHttpClient extends Mock implements HttpClient {}

// ignore: must_be_immutable
class MockLibgenApi extends Mock implements LibgenApi {}

MockLibgenApi defaultMockedClient() {
  final client = MockLibgenApi();
  mockLibgenJsonRequest(client);

  return client;
}

void mockLibgenJsonRequest(MockLibgenApi client) {
  when(client.json(any)).thenAnswer((Invocation invocation) async => invocation
      .positionalArguments.first
      .split(',')
      .map<Map>((id) => booksById[int.parse(id)]?.json)
      .where((e) => e != null)
      .toList(growable: false));
}
