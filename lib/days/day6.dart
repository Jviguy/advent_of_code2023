import 'dart:math';

import 'package:advent_of_code/calendar.dart';

class Day6Solution extends DaySolution {
  @override
  int part1(String input) {
    var [T, D] = input.split("\n").map((e) => RegExp(r'\d+')
        .allMatches(e).map((e) => e.group(0))
        .where((element) => element!=null&&int.tryParse(element)!=null)
        .map((e) => int.parse(e!)).toList()).toList();
    int result = 1;
    for (int race = 0; race < T.length; race++) {
      int c = 0;
      for (int H = 1; H < T[race]; H++) {
        if (H*(T[race]-H)>D[race]) c++;
      }
      if (c!=0) {
        result *= c;
      }
    }
    return result;
  }

  // quadratic formula for bigger nums.
  @override
  int part2(String input) {
    var [tL, dL] = input.replaceAll(' ', '').split("\n").map((e) => RegExp(r'\d+')
        .allMatches(e).map((e) => e.group(0))
        .where((element) => element!=null&&int.tryParse(element)!=null)
        .map((e) => int.parse(e!)).toList()).toList();
    int T = tL[0];
    int D = dL[0];
    double mi = (T-sqrt(pow(T, 2)-4*D))/2;
    double ma = (T+sqrt(pow(T, 2)-4*D))/2;
    return (ma-mi).floor();
  }
}