extension ListExtension<T> on List<T> {
  T get firstOrNull => isEmpty ? null : first;

  List<T> drop(int start, int end) =>
      toList()..removeRange(0, start)..removeRange(length - end, length);
}
