import 'package:libgen/libgen.dart';

void main() async {
  final libgen = await Libgen.any();

  // print(await libgen.getById('1591104'));
  print(await libgen.getById('1'));
  print(await libgen.getByIds(['1', '2']));
}
