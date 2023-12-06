import 'dart:collection';
import 'dart:math';

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

  List<List<int>> map(List<String> lines) {
    List<List<int>> r = [];
    for (String line in lines) {
      List<int> nums = [];
      for (String num in line.split(" ")) {
        nums.add(int.parse(num));
      }
      r.add(nums);
    }
    return r;
  }

  // Credit to Hyperneutrino for this solution, I tried my above solution for part 1 ^^
  // But it failed in terms of speeding up for the number of inputs.
  // I knew I had to do something with the ranges as to shorten the workload,
  // I just didn't know how, I am doing this as a learning experience and -
  // his video greatly helped me understand his approach to splitting the ranges.
  @override
  int part2(String input) {
    List<List<String>> numbers = input
        .split(":")
        .map((e) => e
            .split("\r\n")
            .where((element) => !element.contains('-to-'))
            .where((element) => element.isNotEmpty)
            .toList())
        .where((element) => !element.contains("seeds"))
        .toList();
    List<int> firstLine = numbers
        .removeAt(0)[0]
        .split(" ")
        .where((element) => element.isNotEmpty)
        .map((e) => int.parse(e))
        .toList();
    List<(int,int)> seeds = [];
    for (int i = 0; i < firstLine.length-1; i+=2) {
      seeds.add((firstLine[i], firstLine[i]+firstLine[i+1]));
    }
    for (List<String> blocks in numbers) {
      List<(int,int)> newSeeds = [];
      List<List<int>> ranges = map(blocks);
      while (seeds.isNotEmpty) {
        var (start, end) = seeds.removeLast();
        bool overlap = false;
        for (var [destStart,sourceStart,rangeLen] in ranges) {
          int overlapStart = max(start, sourceStart);
          int overlapEnd = min(end, sourceStart+rangeLen);
          if (overlapStart < overlapEnd) {
            newSeeds.add((overlapStart - sourceStart + destStart,overlapEnd - sourceStart + destStart));
            if (end > overlapEnd) {
              seeds.add((overlapEnd,end));
            }
            if (overlapStart > start) {
              seeds.add((start,overlapStart));
            }
            overlap = true;
            break;
          }
        }
        if (!overlap) {
          newSeeds.add((start,end));
        }
      }
      seeds=newSeeds;
    }
    int m = -1;
    for (var (start,_) in seeds) {
      if (start < m || m == -1) {
        m=start;
      }
    }
    return m;
  }
}
