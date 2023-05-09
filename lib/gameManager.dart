import 'package:flutter/cupertino.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twenty_forty_eight/game.dart';

class GameManager extends ChangeNotifier {
  late Game game;

  GameManager(int best) {
    game = Game(best);
  }

  newGame() {
    int best = game.best;
    game = Game(best);
    notifyListeners();
  }

  void move(SwipeDirection direction) async {
    bool moved = false;
    bool summed = false;
    final pref = await SharedPreferences.getInstance();

    switch (direction) {
      case SwipeDirection.left:
        moved = game.moveLeft();
        summed = game.sumLeft();
        if (summed) game.moveLeft();
        break;
      case SwipeDirection.right:
        moved = game.moveRight();
        summed = game.sumRight();
        if (summed) game.moveRight();
        break;
      case SwipeDirection.up:
        moved = game.moveUp();
        summed = game.sumUp();
        if (summed) game.moveUp();
        break;
      case SwipeDirection.down:
        moved = game.moveDown();
        summed = game.sumDown();
        if (summed) game.moveDown();
        break;
      default:
        break;
    }
    if (game.score >= game.best) {
      game.best = game.score;
      pref.setInt('best', game.best);
    }
    if (summed || moved) game.fillTile();
    notifyListeners();
  }
}
