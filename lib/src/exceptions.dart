import 'package:http/http.dart' show Response;

class HttpException implements Exception {
  final Response response;

  HttpException([this.response]);
}
