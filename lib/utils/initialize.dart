import 'package:flutter_dotenv/flutter_dotenv.dart';

class Initializer {
  static Future<void> initialize() async {
    // アプリの起動時に必要な処理を行う
    await dotenv.load(fileName: ".env");
  }
}
