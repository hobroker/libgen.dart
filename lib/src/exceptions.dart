import 'package:http/http.dart' show Response;

class HttpException implements Exception {
  final Response response;

  HttpException([this.response]);
}

class NoAvailableMirrorException implements Exception {
  factory NoAvailableMirrorException() => Exception('No mirror is available.');
}

// class NoResultsException implements Exception {
//   factory NoResultsException() => Exception('Search did not return any results');
// }
