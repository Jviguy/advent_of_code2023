
import 'package:advent_of_code/calendar.dart';

const Map<String, int> translationTable = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
  "zero": 0
};

class Day1Solution extends DaySolution {
  @override
  int part1(String input) {
    int s = 0;
    for (String line in input.split("\n")) {
      int l = 0;
      int r = line.length-1;
      while (l<r) {
        int la = line.codeUnitAt(l);
        int ra = line.codeUnitAt(r);
        if (!(la >= 48 && la <= 57)) {
          l+=1;
        } else if (ra >= 48 && ra <= 57) {
          break;
        }
        if (!(ra >= 48 && ra <= 57)) {
          r-=1;
        }
      }
      int tens = line.codeUnitAt(l) - 48;
      int ones = line.codeUnitAt(r) - 48;
      s += tens * 10 + ones;
    }
    return s;
  }

  @override
  int part2(String input) {
    int s = 0;
    for (String line in input.split("\n")) {
      int l = 0;
      int r = line.length-1;
      String? ls = wordHelper(line, false);
      String? rs = wordHelper(line, true);
      while (l<r) {
        int la = line.codeUnitAt(l);
        int ra = line.codeUnitAt(r);
        if (!(la >= 48 && la <= 57)) {
          l+=1;
        } else if (ra >= 48 && ra <= 57) {
          break;
        }
        if (!(ra >= 48 && ra <= 57)) {
          r-=1;
        }
      }
      int tens = line.codeUnitAt(l) - 48;
      int ones = line.codeUnitAt(r) - 48;
      if (ls != null) {
        int lsi = line.indexOf(ls);
        if (lsi < l) {
          // use lsi.
          tens = translationTable[ls]!;
        }
      }
      if (rs != null) {
        int rsi = line.lastIndexOf(rs);
        if (rsi > r) {
          // use rsi.
          ones = translationTable[rs]!;
        }
      }
      // if both l and r represent character units / digits in the string.
      s += tens * 10 + ones;
    }
    return s;
  }
}

String? wordHelper(String line, bool last) {
  Iterable<String> patterns = translationTable.keys;
  String? cpattern;
  int i = last?-1:line.length;
  for (String pattern in patterns) {
    if (last) {
      int t = line.lastIndexOf(pattern);
      if (t >= 0 && t > i) {
        cpattern = pattern;
        i = t;
      }
    } else {
      int t = line.indexOf(pattern);
      if (t >= 0 && t < i) {
        cpattern = pattern;
        i = t;
      }
    }
  }
  return cpattern;
}