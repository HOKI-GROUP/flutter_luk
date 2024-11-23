import 'package:example/game_dialog.dart';
import 'package:example/game_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  GameDialog.showGameDialog(context,
                      gameId: 21,
                      gameName: "Jackpot",
                      gameUrl:
                          "https://games.lucky9studio.com/sdk/app_Debug/slotmachine/index.html?half=0");
                },
                child: const Text(
                  "弹窗游戏:Jackpot",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
            const SizedBox(height: 32,),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      //没有传值
                      builder: (context) => const GamePage(
                          gameId: 68,
                          gameName: "Ludo",
                          gameUrl:
                              "https://games.lucky9studio.com/sdk/app_Debug/ludo2/index.html")));
                },
                child: const Text(
                  "互动游戏:Ludo",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
