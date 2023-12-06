import 'dart:collection';

import 'package:advent_of_code/calendar.dart';

class Day5Solution extends DaySolution {
  @override
  int part1(String input) {
    List<Function> mappingFuncs = [];
    List<List<String>> numbers = input
        .split(":")
        .map((e) => e
            .split("\n")
            .where((element) => !element.contains('-to-'))
            .where((element) => element.isNotEmpty)
            .toList())
        .where((element) => !element.contains("seeds"))
        .toList();
    List<int> seeds = numbers
        .removeAt(0)[0]
        .split(" ")
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();
    for (List<String> mappingMembers in numbers) {
      mappingFuncs.add(mappingStringsToFunc(mappingMembers));
    }
    int min = -1;
    for (int seed in seeds) {
      for (Function mapper in mappingFuncs) {
        seed = mapper(seed);
      }
      if (seed < min || min == -1) {
        min = seed;
      }
    }
    return min;
  }

  Function mappingStringsToFunc(List<String> lines) {
    List<List<int>> entries = [];
    for (String line in lines) {
      List<int> nums = [];
      for (String num in line.split(" ")) {
        nums.add(int.parse(num));
      }
      entries.add(nums);
    }
    return (int inp) {
      for (List<int> entry in entries) {
        if (inp >= entry[1] && inp < entry[1] + entry[2]) {
          // Its in the range.
          return entry[0] + inp - entry[1];
        }
      }
      // if all other cases fail return direct mapping.
      return inp;
    };
  }

  HashMap<int, int> map(List<String> lines) {
    HashMap<int, int> r = HashMap();
    for (String line in lines) {
      List<int> nums = [];
      for (String num in line.split(" ")) {
        nums.add(int.parse(num));
      }
      for (int i = 0; i < nums[2]; i++) {
        r.putIfAbsent(nums[0] + i, () => nums[1] + i);
      }
    }
    return r;
  }

  @override
  int part2(String input) {
    List<List<String>> numbers = input
        .split(":")
        .map((e) => e
            .split("\n")
            .where((element) => !element.contains('-to-'))
            .where((element) => element.isNotEmpty)
            .toList())
        .where((element) => !element.contains("seeds"))
        .toList();
    List<int> seeds = numbers
        .removeAt(0)[0]
        .split(" ")
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();
    int min = -1;
    print("TEST");
    for (List<String> mapS in numbers) {
      HashMap<int, int> conversionMap = map(mapS);
      for (int i = 0; i < seeds.length; i++) {
        if (conversionMap.containsKey(seeds[i])) {
          seeds[i] = conversionMap[seeds[i]] ?? seeds[i];
        }
      }
    }
    return min;
  }
}
