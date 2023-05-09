import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twenty_forty_eight/gameField.dart';
import 'package:twenty_forty_eight/gameManager.dart';

import 'gameMenu.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late Size worldSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getWidth(MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Consumer<GameManager>(builder: (context, state, child) {
            return SwipeDetector(
              onSwipe: (direction, offset) {
                state.move(direction);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const GameMenu(),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0),
                          child: Center(
                            child: Container(
                              width: worldSize.width,
                              height: worldSize.height,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.brown[300]),
                              child: const GameField(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  getWidth(double w) {
    double width = w - (32 * 2);
    setState(() {
      worldSize = Size(width, width);
    });
  }
}
