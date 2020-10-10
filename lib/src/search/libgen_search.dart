import 'package:meta/meta.dart';

import '../list_extension.dart';
import '../parser.dart';
import 'compute_pagination.dart';
import 'page_options.dart';

typedef SearchRequest = Future<LibgenPageParser> Function(Map<String, String>);

@immutable
class LibgenSearch {
  final String text;
  final int count;
  final int offset;
  final String sortBy;
  final String searchIn;
  final bool asc;
  final List<PageOptions> _nav;

  LibgenSearch({
    @required this.text,
    this.count,
    this.offset,
    this.sortBy,
    this.searchIn,
    this.asc,
  }) : _nav = computePagination(count, offset: offset);

  Map<String, String> get defaultParams => {
        'req': text,
        'column': searchIn,
        'sort': sortBy,
        'sortmode': asc ? 'ASC' : 'DESC',
        'view': 'simple',
      };

  Future<List<int>> run(SearchRequest search) async {
    final idsAcc = <int>[];

    for (final page in _nav) {
      final query = {
        'page': page.page,
        'res': page.limit,
      }..addAll(defaultParams);
      final data = await search(query);
      final ids = data.ids.drop(page.ignoreFirst, page.ignoreLast);

      idsAcc.addAll(ids);
    }

    return idsAcc;
  }
}
