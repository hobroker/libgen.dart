import 'package:html/dom.dart';
import 'package:html/parser.dart';

class PageParser {
  final String html;
  final Document _document;

  PageParser(this.html) : _document = parse(html);

  List<int> get ids => _rows.map<int>(_extractRowId).toList(growable: false);

  int get firstId => _extractRowId(_rows.first);

  List get _rows => _document.querySelectorAll('.c tr')..removeAt(0);

  int _extractRowId(el) => int.parse(el.querySelector('td').text);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageParser &&
          runtimeType == other.runtimeType &&
          html == other.html;

  @override
  int get hashCode => html.hashCode;
}
