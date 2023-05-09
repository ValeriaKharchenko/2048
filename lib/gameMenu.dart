import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gameManager.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({Key? key}) : super(key: key);

  @override
  State<GameMenu> createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameManager>(builder: (context, state, child) {
      final game = state.game;
      return Wrap(
        children: <Widget>[
          const SizedBox(
            width: 200,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.brown[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Score:",
                    style: TextStyle(color: Colors.brown[100]),
                  ),
                  Text("${game.score}",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.brown[300],
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Best", style: TextStyle(color: Colors.brown[100])),
                  Text("${game.best}",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Center(
              child: Text(
                '2048',
                style: TextStyle(
                  fontSize: 55.0,
                  color: Colors.brown[800],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: () => {state.newGame()}, //todo
                child: const Text('New game'),
              ),
            ),
          ),
        ],
      );
    });
  }
}
