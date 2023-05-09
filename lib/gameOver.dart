import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gameManager.dart';

class GameOverDialog extends StatelessWidget {
  final String text;

  const GameOverDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('YOU $text'),
      actions: [
        Consumer<GameManager>(builder: (context, state, child) {
          return ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (
                          _,
                          __,
                          ___,
                        ) =>
                            state.newGame(),
                        transitionDuration: Duration.zero));
              },
              child: const Text('New game'));
        })
      ],
    );
  }
}
