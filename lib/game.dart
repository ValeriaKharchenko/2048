import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

enum Direction { up, down, right, left }

class Game {
  int score = 0;
  int best; //todo
  bool over = false;
  bool won = false;
  List<List<int>> field = [];
  int fieldSize = 4;

  Game(this.best) {
    for (int i = 0; i < fieldSize; i++) {
      field.add(List.filled(fieldSize, 0));
    }
    int r = Random().nextInt(2) + 3;
    for (int i = 0; i < r; i++) {
      fillTile();
    }
  }

  void fillTile() {
    int rX = Random().nextInt(4);
    int rY = Random().nextInt(4);
    int rV = Random().nextInt(2);
    if (field[rY][rX] != 0) {
      fillTile();
    } else {
      field[rY][rX] = (rV + 1) * 2;
    }
    bool hasEmptyTile = false;
    for (int i = 0; i < fieldSize; i++) {
      if (field[i].contains(0)) {
        hasEmptyTile = true;
        break;
      }
    }
    if (!hasEmptyTile) over = true;
  }

  bool moveLeft() {
    bool moved = false;
    for (int i = 0; i < fieldSize; i++) {
      int emptyTiles = 0;
      int j = 0;
      while (j < fieldSize) {
        if (j + emptyTiles >= fieldSize) {
          field[i][j] = 0;
          j++;
          continue;
        }
        if (field[i][j + emptyTiles] != 0) {
          if (field[i][j] != field[i][j + emptyTiles]) moved = true;
          field[i][j] = field[i][j + emptyTiles];
          j++;
        } else {
          emptyTiles++;
        }
      }
    }
    return moved;
  }

  bool sumLeft() {
    bool sum = false;
    for (int i = 0; i < fieldSize; i++) {
      for (int j = 0; j < fieldSize - 1; j++) {
        if (field[i][j] == field[i][j + 1] && field[i][j] != 0) {
          field[i][j] *= 2;
          score += field[i][j];
          if (field[i][j] == 2048) {
            won = true;
          }
          if (field[i][j] == 16) {
            won = true;
          }
          field[i][j + 1] = 0;
          sum = true;
        }
      }
    }
    return sum;
  }

  bool moveRight() {
    bool moved = false;
    for (int i = 0; i < fieldSize; i++) {
      int emptyTiles = 0;
      int j = fieldSize - 1;
      while (j >= 0) {
        if (j - emptyTiles < 0) {
          field[i][j] = 0;
          j--;
          continue;
        }
        if (field[i][j - emptyTiles] >= 0 && field[i][j - emptyTiles] != 0) {
          if (field[i][j] != field[i][j - emptyTiles]) moved = true;
          field[i][j] = field[i][j - emptyTiles];
          j--;
        } else {
          emptyTiles++;
        }
      }
    }
    return moved;
  }

  bool sumRight() {
    bool sum = false;
    for (int i = 0; i < fieldSize; i++) {
      for (int j = fieldSize - 1; j > 0; j--) {
        if (field[i][j] == field[i][j - 1] && field[i][j] != 0) {
          field[i][j] *= 2;
          score += field[i][j];
          if (field[i][j] == 2048) {
            won = true;
          }
          if (field[i][j] == 16) {
            won = true;
          }
          field[i][j - 1] = 0;
          sum = true;
        }
      }
    }
    return sum;
  }

  bool moveUp() {
    bool moved = false;
    for (int j = 0; j < fieldSize; j++) {
      int emptyTiles = 0;
      int i = 0;
      while (i < fieldSize) {
        if (i + emptyTiles >= fieldSize) {
          field[i][j] = 0;
          i++;
          continue;
        }
        if (field[i + emptyTiles][j] != 0) {
          if (field[i][j] != field[i + emptyTiles][j]) moved = true;
          field[i][j] = field[i + emptyTiles][j];
          i++;
        } else {
          emptyTiles++;
        }
      }
    }
    return moved;
  }

  bool sumUp() {
    bool sum = false;
    {
      for (int j = 0; j < fieldSize; j++) {
        for (int i = 0; i < fieldSize - 1; i++) {
          if (field[i][j] == field[i + 1][j] && field[i][j] != 0) {
            sum = true;
            field[i][j] *= 2;
            score += field[i][j];
            if (field[i][j] == 2048) {
              won = true;
            }
            if (field[i][j] == 16) {
              won = true;
            }
            field[i + 1][j] = 0;
          }
        }
      }
    }
    return sum;
  }

  bool moveDown() {
    bool moved = false;
    for (int j = fieldSize - 1; j >= 0; j--) {
      int i = fieldSize - 1;
      int emptyTiles = 0;
      while (i >= 0) {
        if (i - emptyTiles < 0) {
          field[i][j] == 0;
          i--;
          continue;
        }
        if (field[i - emptyTiles][j] >= 0 && field[i - emptyTiles][j] != 0) {
          if (field[i][j] != field[i - emptyTiles][j]) moved = true;
          field[i][j] = field[i - emptyTiles][j];
          i--;
        } else {
          emptyTiles++;
        }
      }
    }
    return moved;
  }

  bool sumDown() {
    bool sum = false;
    for (int j = fieldSize - 1; j >= 0; j--) {
      for (int i = fieldSize - 1; i > 0; i--) {
        if (field[i][j] == field[i - 1][j] && field[i][j] != 0) {
          sum = true;
          field[i][j] *= 2;
          score += field[i][j];
          if (field[i][j] == 2048) {
            won = true;
          }
          if (field[i][j] == 16) {
            won = true;
          }
          field[i - 1][j] = 0;
        }
      }
    }
    return sum;
  }
}
