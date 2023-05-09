import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twenty_forty_eight/gameManager.dart';

import 'gamePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  int best = pref.getInt('best') ?? 0;

  runApp( ChangeNotifierProvider(
    create: (context) => GameManager(best),
      child: const GameApp()));
}

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '2048',
      home: GamePage(),
    );
  }
}

