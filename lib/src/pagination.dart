import 'dart:math';

const _PAGE_SIZES = [25, 50, 100];
final _MIN_PAGE_SIZE = _PAGE_SIZES.first;
final _MAX_PAGE_SIZE = _PAGE_SIZES.last;

/// The point of this class is to calculate the optimal [page] and [limit]
/// needed for the Libgen API.
/// Could be improved, but at the moment it's the best solution I can think of.
class Pagination {
  final int total;
  final int offset;

  /// intenal current useful results count
  int _count;

  /// intenal current offset, public with [ignoreFirst]
  int _offset;

  /// current page limit, public with [limit]
  int _limit;

  /// current page number, public with [page]
  int _page = 1;

  /// the number of items that have been fetched (useful or ignored ones)
  int _sink = 0;

  /// Required [total] number of items and ptionally accepts an [offset].
  Pagination(this.total, {this.offset = 0})
      : assert(total > 0),
        assert(offset >= 0) {
    _count = min(_MAX_PAGE_SIZE, total);
    _offset = offset;

    final startsOnFirstPage = _offset < 25;
    if (!startsOnFirstPage) {
      while (_offset > 0) {
        final localLimit = _computeLimit(_offset, true);
        if (_offset - localLimit < 0) {
          break;
        }
        _offset -= localLimit;
        _page++;
        _sink += localLimit;
      }
    }

    _updateLimit();
  }

  /// calculates values for the next page
  void next() {
    assert(hasNext);
    _page++;
    _updateLimit();

    _offset = 0;
    _count = (_sink - total).abs();
  }

  void _updateLimit() {
    _limit = _computeLimit(total - _sink);
    _sink += _limit;
  }

  /// True if there are more pages to fetch
  bool get hasNext => _sink < total + offset;

  /// The page size for Ligen API
  int get limit => _limit;

  /// The page number for Libgen API
  int get page => _page;

  /// The number of items the client should ignore at the start of the [List]
  int get ignoreFirst => _offset;

  /// The number of items the client should ignore at the end of the [List]
  int get ignoreLast {
    print('_count: ${_count}');
    return hasNext || _count >= _limit
        ? 0
        : _offset == 0 ? _limit - _count : _limit - _count - _offset;
  }

  int _computeLimit(int count, [bool lower = false]) {
    if (count > _MAX_PAGE_SIZE) {
      return _MAX_PAGE_SIZE;
    }

    for (var idx = 0; idx < _PAGE_SIZES.length; idx++) {
      final item = _PAGE_SIZES[idx];
      final div = count / item;

      if (div <= 1) {
        if (lower && idx > 0 && div != 1) {
          return _PAGE_SIZES[idx - 1];
        }

        return item;
      }
    }

    return _MIN_PAGE_SIZE;
  }
}
