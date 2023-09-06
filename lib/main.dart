import 'package:flutter/material.dart';

import 'utils/footer.dart';
import 'utils/initialize.dart';
import 'utils/request.dart';

void main() async {
  await Initializer.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            ElevatedButton(
              child: const Text("サーバーを決定"),
              onPressed: () {
                // TODO: サーバーアドレス入力
                RequestManager().serverAddress = "ADDRESS";
              },
            ),
            ElevatedButton(
              child: const Text("ルームを作成"),
              onPressed: () {
                // TODO: ルーム作成処理
              },
            ),
            // TODO: ルームIDとユーザー名の入力
            ElevatedButton(
              child: Text("ルームに参加"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RootWidget()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
