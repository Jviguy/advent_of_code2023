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
    // instantiate count.
    List<String> lines = input.split("\n");
    Map<int,int> count = {for (int i = 0; i < lines.length; i++) i: 1};
    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      var [_, nums] = line.split(": ");
      var [winningNums, pulledNums] = nums.split(" | ");
      List<int> winners = extractNums(winningNums);
      List<int> pulled = extractNums(pulledNums);
      int cloneValue = 0;
      for (int num in pulled) {
        if (winners.contains(num)) {
          cloneValue++;
        }
      }
      for (int j = i+1; j < cloneValue+i+1; j++) {
        count.update(j, (value) => value+(count[i]??1));
      }
    }
    return sum(count);
  }

  int sum(Map<int,int> list) {
    int s = 0;
    list.forEach((key, value) {
      s += value;
    });
    return s;
  }
}
