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
    List<int> count = [];
    List<int> cloneValues = [];
    // get cloneValues and instantiate count.
    for (String line in input.split("\n")) {
      var [_, nums] = line.split(": ");
      count.add(1);
      var [winningNums, pulledNums] = nums.split(" | ");
      List<int> winners = extractNums(winningNums);
      List<int> pulled = extractNums(pulledNums);
      int cloneValue = 0;
      for (int num in pulled) {
        if (winners.contains(num)) {
          cloneValue++;
        }
      }
      cloneValues.add(cloneValue);
    }
    for (int i = 0; i < count.length; i++) {
      int countToBeAdded = count[i];
      int rightIndexRange = cloneValues[i];
      for (int j = i+1; j < i+1+rightIndexRange; j++) {
        count[j]+=countToBeAdded;
      }
    }
    return sum(count);
  }

  int sum(List<int> list) {
    int s = 0;
    for (int v in list) {
      s += v;
    }
    return s;
  }
}
