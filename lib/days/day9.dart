import 'package:advent_of_code/calendar.dart';

typedef SequenceMap = List<List<int>>;

class Day9Solution extends DaySolution {
  @override
  int part1(String input) {
    List<List<int>> sequences = input.split("\r\n").map((e) => e.split(" ").map((e) => int.parse(e)).toList()).toList();
    int s = 0;
    for (List<int> sequence in sequences) {
      SequenceMap map = sequenceToSequenceMap(sequence);
      s += extrapolateNext(map);
    }
    return s;
  }

  int extrapolateNext(SequenceMap map) {
    int next = 0;
    print(map);
    for (int i = 0; i < map.length; i++) {
      // add last value of each sequence to the next var
      next += map[i][map[i].length-1];
    }
    return next;
  }

  /// sequenceToSequenceMap turns a sequence into a pyramid based list of sequences.
  /// This is used with the extrapolate function.
  SequenceMap sequenceToSequenceMap(List<int> sequence) {
    SequenceMap sequenceMap = [sequence];
    while (!isAllZeros(sequenceMap[sequenceMap.length-1])) {
      List<int> seq = sequenceMap[sequenceMap.length-1];
      List<int> newSequence = [];
      for (int i = 1; i < seq.length; i++) {
        newSequence.add((seq[i]-seq[i-1]));
      }
      sequenceMap.add(newSequence);
    }
    return sequenceMap;
  }

  bool isAllZeros(List<int> list) {
    for (int i in list) {
      if (i!=0) {
        return false;
      }
    }
    return true;
  }

  int extrapolatePrevious(SequenceMap map) {
    int next = 0;
    // reverse up the map
    for (int i = map.length-1; i >= 0; i--) {
      next = map[i][0]-next;
    }
    return next;
  }

  @override
  int part2(String input) {
    List<List<int>> sequences = input.split("\r\n").map((e) => e.split(" ").map((e) => int.parse(e)).toList()).toList();
    int s = 0;
    for (List<int> sequence in sequences) {
      SequenceMap map = sequenceToSequenceMap(sequence);
      s += extrapolatePrevious(map);
    }
    return s;
  }
}