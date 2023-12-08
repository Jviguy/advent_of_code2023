import 'dart:collection';

import 'package:advent_of_code/calendar.dart';

int lcm(int a, int b) => (a * b) ~/ gcd(a, b);

int lcmList(Iterable<int> list) {
  int a = 1;
  for (int i in list) {
    a = lcm(i, a);
  }
  return a;
}

int gcd(int a, int b) {
  while (b != 0) {
    var t = b;
    b = a % t;
    a = t;
  }
  return a;
}

class Day8Solution extends DaySolution {
  @override
  int part1(String input) {
    List<String> lines = input.split("\r\n");
    List<int> lrList =
        lines.removeAt(0).split('').map((e) => e == "L" ? 0 : 1).toList();
    lines.removeAt(0);
    HashMap<String, List<String>> map = HashMap();
    for (String line in lines) {
      var [key, values] = line.split(" = (");
      var [l, r] = values.substring(0, values.length - 1).split(", ");
      map[key] = [l, r];
    }
    String currString = "AAA";
    int step = 0;
    while (currString != "ZZZ") {
      currString = map[currString]![lrList[step % lrList.length]];
      step++;
    }
    return step;
  }

  @override
  int part2(String input) {
    List<String> lines = input.split("\r\n");
    List<int> lrList =
    lines.removeAt(0).split('').map((e) => e == "L" ? 0 : 1).toList();
    lines.removeAt(0);
    HashMap<String, List<String>> map = HashMap();
    for (String line in lines) {
      var [key, values] = line.split(" = (");
      var [l, r] = values.substring(0, values.length - 1).split(", ");
      map[key] = [l, r];
    }
    List<String> currStrings = [];
    for (String key in map.keys) {
      if (key[key.length-1] == "A") {
        currStrings.add(key);
      }
    }
    int step = 0;
    // Here we are going to store, for all currentStrings, where that path reaches
    // A XXZ String. Once this map has been filled, len == currStrings.length,
    // We need to find the least common multiple in this map.
    // This will be the number of steps needed to get to the state in which all Z strings are there.
    HashMap<int, int> zMap = HashMap();
    while (true) {
      for (int i = 0; i < currStrings.length; i++) {
        currStrings[i] = map[currStrings[i]]![lrList[step % lrList.length]];
        if (currStrings[i][currStrings[i].length-1] == "Z") {
          // If last char is a Z we found its z occurrence idx.
          // Increase this by one as to ensure that lcm works if step = 0.
          zMap[i] = step+1;
          if (zMap.length == currStrings.length) {
            return lcmList(zMap.values);
          }
        }
      }
      step++;
    }
  }
}
