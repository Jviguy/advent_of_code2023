import 'dart:io';

import 'days/days.dart';

typedef DaySolution<R> = R Function(String input);

class Calendar {
  final List<DaySolution> solutions = [day1,day2];
  String inputDirectory;

  Calendar({required this.inputDirectory});

  R executeSolution<R>(int day) {
    if (day >= 1 && day <= solutions.length) {
      File file = File("$inputDirectory/day$day.txt");
      String input = file.readAsStringSync();
      return solutions[day - 1](input);
    } else {
      throw ArgumentError('Invalid day');
    }
  }
}

