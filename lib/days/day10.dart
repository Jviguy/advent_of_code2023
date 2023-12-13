import 'dart:collection';

import 'package:advent_of_code/calendar.dart';

Map<String, List<(int, int)>> direcList = {
  "|": [(1,0),(-1,0)],
  "-": [(0,1),(0,-1)],
  "L": [(1,0), (0,1)],
  "J": [(1,0), (0,-1)],
  "7": [(-1,0), (0,-1)],
  "F": [(-1,0), (0,1)],
  "S": [(0,-1), (1,0), (0,1), (-1,0)]
};

class Day10Solution extends DaySolution {
  @override
  int part1(String input) {
    List<String> lines = input.split("\r\n");
    (int,int) startPos = (-1,-1);
    for (int i = 0; i < lines.length; i++) {
      for (int j = 0; j < lines[i].length; j++) {
        if (lines[i][j] == "S") {
          startPos = (i,j);
          break;
        }
      }
      if (startPos != (-1,-1)) {
        break;
      }
    }
    breadthFirstFill(lines, startPos);
    return 0;
  }

  int breadthFirstFill(List<String> lines, (int,int) startingPos) {
    Queue<(int,int)> q = Queue();
    HashSet<(int,int)> visited = HashSet();
    visited.add(startingPos);
    for ((int,int) adj in direcList[lines[startingPos.$1][startingPos.$2]]!) {
      int newRow = startingPos.$1 + adj.$1;
      int newCol = startingPos.$2 + adj.$2;
      if (newRow>=0&&newRow<lines.length&&newCol>=0&&newCol<lines.length) {
        // new valid position.
        if (checkValidStartingConnection(lines, (newRow, newCol), startingPos)) {
          // the new valid starting pos to the q.
          q.add((newRow, newCol));
        }
      }
    }
    while (q.isNotEmpty) {
      // remove from end as to properly do BFS. zig zag pattern thingy.
      (int,int) pos = q.removeLast();
      visited.add(pos);
      for ((int,int) diff in direcList[lines[pos.$1][pos.$2]]!) {
        print((pos.$1+diff.$1, pos.$2+diff.$2));
        // if already visited keep going.
        if (visited.contains((pos.$1+diff.$1, pos.$2+diff.$2))) {
          continue;
        }
        // if its a valid connection to this pipe.
        if (checkValidStartingConnection(lines, (pos.$1+diff.$1, pos.$2+diff.$2), pos)) {
          print(lines[pos.$1+diff.$1][pos.$2+diff.$2]);
          q.add((pos.$1+diff.$1, pos.$2+diff.$2));
        }
      }
    }
    return 0;
  }

  bool checkValidStartingConnection(List<String> lines, (int,int) pipe, (int,int) startingPos) {
    if (direcList[lines[pipe.$1][pipe.$2]] == null) {
      return false;
    }
    for ((int,int) diff in direcList[lines[pipe.$1][pipe.$2]]!) {
      // if the directions from that pipe connects to the startingPosition than we know its a valid connection to the starting point.
      if ((pipe.$1 + diff.$1, pipe.$2+diff.$2) == startingPos) {
        return true;
      }
    }
    return false;
  }

  @override
  int part2(String input) {
    // TODO: implement part2
    throw UnimplementedError();
  }
  
}