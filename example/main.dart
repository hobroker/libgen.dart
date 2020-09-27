import 'package:libgen/libgen.dart';

void main() async {
  final libgen = await LibgenMirror.any();

  final result = await libgen.getByIds([1591104]);
  print(result);
}
