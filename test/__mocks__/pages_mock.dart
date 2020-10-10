import 'package:http/http.dart' as http;

Future<String> get searchPage => http
    .get('http://libgen.rs/search.php?req=something')
    .then((res) => res.body);
