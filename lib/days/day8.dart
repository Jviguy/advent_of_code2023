import 'dart:collection';

import 'package:advent_of_code/calendar.dart';

class Day8Solution extends DaySolution {
  @override
  int part1(String input) {
    List<String> lines = input.split("\n");
    List<int> lrList =
        lines.removeAt(0).split('').map((e) => e == "L" ? 0 : 1).toList();
    lines.removeAt(0);
    HashMap<String, List<String>> map = HashMap();
    for (String line in lines) {
      var [key, values] = line.split(" = (");
      var [l, r] = values.substring(0, values.length - 1).split(", ");
      map[key] = [l, r];
    }
    print(map);
    String currString = "AAA";
    int step = 0;
    while (currString != "ZZZ") {
      currString = map[currString]![lrList[step % 2]];
      step++;
    }
    return step;
  }

  @override
  int part2(String input) {
    // TODO: implement part2
    throw UnimplementedError();
  }
}
