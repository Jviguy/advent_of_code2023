import 'dart:collection';

import 'package:advent_of_code/calendar.dart';

class Day3Solution extends DaySolution {
  @override
  int part1(String input) {
    int s = 0;
    List<String> grid = input.split("\n");
    List<List<bool>> partGrid = [];
    // make part number grid.
    for (int i = 0; i < grid.length; i++) {
      partGrid.add([]);
      for (int j = 0; j < grid.length; j++) {
        partGrid[i].add(false);
      }
    }
    // Start floodFill process:
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        String char = grid[i][j];
        if (int.tryParse(char)==null&&char!='.') {
          // found symbol, flood fill from this position.
          floodFill(grid, partGrid, i,j);
        }
      }
    }
    // now we just need to collect the numbers.
    for (int i = 0; i < grid.length; i++) {
      int n = 0;
      for (int j = 0; j < grid.length; j++) {
        if (partGrid[i][j]) {
          n = n*10+int.parse(grid[i][j]);
        } else if (n>0) {
          s += n;
          n=0;
        } else {
          n=0;
        }
      }
      if (n > 0) {
        s+=n;
      }
    }
    return s;
  }

  /// floodFill implements recursive BFS to find adjacent numbers to a given symbol.
  floodFill(List<String> grid, List<List<bool>> partGrid, int row, int col) {
    partGrid[row][col] = int.tryParse(grid[row][col])!=null;
    // 3by3 grid around the given number.
    for (int ri in [-1,0,1]) {
      for (int ci in [-1,0,1]) {
        int adjR = row+ri;
        int adjC = col+ci;
        // make sure in bounds.
        if (adjR>=0&&adjR<grid.length&&adjC>=0&&adjC<grid.length) {
          // if not visited and its a number visit it.
          if (!partGrid[adjR][adjC]&&int.tryParse(grid[adjR][adjC])!=null) {
            floodFill(grid, partGrid, adjR, adjC);
          }
        }
      }
    }
  }

  @override
  int part2(String input) {
    int s = 0;
    List<String> grid = input.split("\n");
    List<List<int>> identGrid = [];
    // ident grid will now be a heatmap, in which the degrees of heat represent
    // the adjecent numbers that make up gear sets. This makes it easier to collect the numbers into pairs.
    for (int i = 0; i < grid.length; i++) {
      identGrid.add([]);
      for (int j = 0; j < grid.length; j++) {
        identGrid[i].add(0);
      }
    }
    int id = 0;
    // Start floodFill process:
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        String char = grid[i][j];
        // only flood fill from stars now.
        if (char == '*') {
          part2FloodFill(grid, identGrid, i, j, ++id);
        }
      }
    }
    // gather id zones into pairs of numbers in gears map.
    HashMap<int, List<int>> gears = HashMap();
    int currId = -1;
    for (int i = 0; i < grid.length; i++) {
      int n = 0;
      for (int j = 0; j < grid.length; j++) {
        // if real group.
        if (identGrid[i][j] != 0) {
          currId = identGrid[i][j];
          n = n * 10 + int.parse(grid[i][j]);
        } else if (n>0 && currId != -1) {
          gears.putIfAbsent(currId, () => []);
          gears[currId]?.add(n);
          currId = -1;
          n=0;
        }
      }
      // handle end of line numbers. So .....22*22, this should be 22*22
      // without this code it would simply just be the number 22 with an id = 1 no second pair.
      if (n>0 && currId != -1) {
        gears.putIfAbsent(currId, () => []);
        gears[currId]?.add(n);
        currId = -1;
        n=0;
      }
    }
    // loop over each id group / gear pair. If there is only two then multi and add to s.
    gears.forEach((key, value) {
      if (value.length == 2) {
        s += value[0]*value[1];
      }
    });
    return s;
  }

  part2FloodFill(List<String> grid, List<List<int>> identGrid, int row, int col, id) {
    identGrid[row][col] = int.tryParse(grid[row][col])!=null?id:0;
    // 3by3 grid around the given number.
    for (int ri in [-1, 0, 1]) {
      for (int ci in [-1, 0, 1]) {
        int adjR = row + ri;
        int adjC = col + ci;
        // make sure in bounds.
        if (adjR >= 0 && adjR < grid.length && adjC >= 0 &&
            adjC < grid.length) {
          // if not visited and its a number visit it.
          if (identGrid[adjR][adjC] == 0 &&
              int.tryParse(grid[adjR][adjC]) != null) {
            part2FloodFill(grid, identGrid, adjR, adjC, id);
          }
        }
      }
    }
    return;
  }
}