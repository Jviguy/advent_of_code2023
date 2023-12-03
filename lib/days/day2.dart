import 'dart:collection';

import 'package:advent_of_code/calendar.dart';

class Day2Solution extends DaySolution {

  @override
  int part1(String input) {
    int s = 0;
    for (String line in input.split("\n")) {
      var [idSection, game] = line.split(": ");
      int id = int.parse(idSection.split(" ")[1]);
      bool possible = true;
      for (String round in game.split("; ")) {
        for (String cubes in round.split(", ")) {
          var [amts, color] = cubes.split(" ");
          int amt = int.parse(amts);
          switch (color) {
            case "blue":
              possible = amt <= 14;
            case "green":
              possible = amt <= 13;
            case "red":
              possible = amt <= 12;
          }
          if (!possible) {
            break;
          }
        }
        if (!possible) {
          break;
        }
      }
      if (possible) {
        s+=id;
      }
    }
    return s;
  }

  @override
  int part2(String input) {
    int s = 0;
    for (String line in input.split("\n")) {
      var [idSection, game] = line.split(": ");
      int id = int.parse(idSection.split(" ")[1]);
      HashMap<String, int> colorMap = HashMap();
      for (String round in game.split("; ")) {
        for (String cubes in round.split(", ")) {
          var [amts, color] = cubes.split(" ");
          int amt = int.parse(amts);
          colorMap.update(color, (value) => amt>value?amt:value, ifAbsent: ()=>amt);
        }
      }
      int r = 1;
      for (int min in colorMap.values) {
        r *= min;
      }
      s+=r;
    }
    return s;
  }
}
