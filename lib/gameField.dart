import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twenty_forty_eight/gameOver.dart';
import 'package:twenty_forty_eight/utils.dart';

import 'gameManager.dart';

class GameField extends StatefulWidget {
  const GameField({Key? key}) : super(key: key);

  @override
  _GameFieldState createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameManager>(builder: (context, state, child) {
      final game = state.game;
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: game.fieldSize,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        // itemBuilder: _buildGridItems,
        itemCount: game.fieldSize * game.fieldSize,
        itemBuilder: (BuildContext context, index) {
          int x = (index / game.fieldSize).floor();
          int y = (index % game.fieldSize);
          return game.won || game.over
              ? const GameOverDialog(text: 'WON')
              : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: valueToColor[game.field[x][y]],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    game.field[x][y] == 0 ? "" : "${game.field[x][y]}",
                    style: const TextStyle(fontSize: 25.0),
                  ),
                );
        },
      );
    });
  }
}
