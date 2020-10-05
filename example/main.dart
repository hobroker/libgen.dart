import 'package:libgen/libgen.dart';
import 'package:libgen/src/models/search.dart';

void main() async {
  final libgen = await Libgen.any();

  print(await libgen.getById(1591104));
  // print(await libgen.getById(1));
  // print(await libgen.getByIds([1, 2]));
  // print(await libgen.getLatestId());
  // print(await libgen.getLatestMd5());
  // print(await libgen.getLatest());
  print(await libgen.search(
    text: 'dark',
    count: 10,
    searchIn: SearchColumn.title,
  ));
}
