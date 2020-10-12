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

Map<K, V> pick<K, V>(Map<K, V> json, List<K> keys) =>
    Map<K, V>.fromEntries(keys.map((key) => MapEntry(key, json[key])));

String enumValue(Object value) => value.toString().split('').last;
