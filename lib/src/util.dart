import 'dart:convert';

int minNonNullIndex(List list) {
  if (list.length == 1) {
    return 0;
  }

  var minIdx;
  var idx = list.length;
  while (idx-- != 0) {
    if (list[idx] != null && (minIdx == null || list[idx] < list[minIdx])) {
      minIdx = idx;
    }
  }

  return minIdx;
}

String beautify(Map json) => JsonEncoder.withIndent('  ').convert(json);

String enumValue(Object value) => value.toString().split('').last;

int getResultsCount(int count) {
  final counts = [25, 50, 100];

  if (count > counts.last) {
    return counts.last;
  }

  for (final item in counts) {
    if (item % count < item) {
      return item;
    }
  }

  return counts.first;
}
