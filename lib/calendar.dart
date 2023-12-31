import 'dart:io';

import 'days/days.dart';

abstract class DaySolution {
  int part1(String input);
  int part2(String input);
}

class Calendar {
  final List<DaySolution> solutions = [
    Day1Solution(),
    Day2Solution(),
    Day3Solution(),
    Day4Solution(),
    Day5Solution(),
    Day6Solution(),
    Day7Solution(),
    Day8Solution(),
    Day9Solution(),
    Day10Solution(),
  ];
  String inputDirectory;

  Calendar({required this.inputDirectory});

  int executeSolution(int day, int part) {
    if (day >= 1 && day <= solutions.length) {
      File file = File("$inputDirectory/day$day.txt");
      String input = file.readAsStringSync().trim();
      if (part == 1) {
        return solutions[day - 1].part1(input);
      } else {
        return solutions[day - 1].part2(input);
      }
    } else {
      throw ArgumentError('Invalid day');
    }
  }
}
