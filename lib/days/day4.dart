import 'package:advent_of_code/calendar.dart';

class Day4Solution extends DaySolution {
  @override
  int part1(String input) {
    int points = 0;
    for (String line in input.split("\n")) {
      var [_, nums] = line.split(": ");
      int p = 0;
      var [winningNums, pulledNums] = nums.split(" | ");
      List<int> winners = extractNums(winningNums);
      List<int> pulled = extractNums(pulledNums);
      for (int num in pulled) {
        if (winners.contains(num)) {
          if (p == 0) {
            p = 1;
          } else {
            p *= 2;
          }
        }
      }
      points += p;
    }
    return points;
  }

  List<int> extractNums(String listOfNums) {
    List<int> r = [];
    int n = 0;
    for (int i = 0; i < listOfNums.length; i++) {
      if (listOfNums[i] != " ") {
        n = n * 10 + int.parse(listOfNums[i]);
      } else if (n > 0) {
        r.add(n);
        n = 0;
      }
    }
    if (n > 0) {
      r.add(n);
      n = 0;
    }
    return r;
  }

  @override
  int part2(String input) {
    List<String> lines = input.split("\n");
    int i = 0;
    while (i < lines.length) {
      String line = lines[i];
      var [_, nums] = line.split(": ");
      int p = 0;
      var [winningNums, pulledNums] = nums.split(" | ");
      List<int> winners = extractNums(winningNums);
      List<int> pulled = extractNums(pulledNums);
      for (int num in pulled) {
        if (winners.contains(num)) {
          p++;
        }
      }
      for (int j = i + 1; j < p + i + 4; j += 2) {
        print(j);
        lines.insert(j, lines[j]);
      }
      print(lines);
      if (i == 1) {
        break;
      }
      i++;
    }
    return lines.length;
  }
}
