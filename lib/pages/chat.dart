// チャットが表示される．
// サーバーからのメッセージと，陣営内のメッセージが表示される．
// チャットのテキストフィールドと送信ボタンも必要．
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Text("チャット画面です"),
    );
  }
}
