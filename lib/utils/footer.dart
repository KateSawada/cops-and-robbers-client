import 'package:flutter/material.dart';
//footerの参考：//https://www.apps-gcp.com/introduction-of-flutter-about-header-and-RootWidget/

import '../pages/arrest.dart';
import '../pages/chat.dart';
import '../pages/home.dart';
import '../pages/map.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  RootWidgetState createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  // アイコン情報
  static const List<IconData> _rootWidgetIcons = [
    Icons.home,
    Icons.my_location,
    Icons.question_answer,
    Icons.pan_tool,
  ];

  // アイコン文字列
  static const List<String> _rootWidgetItemNames = [
    'ホーム',
    '位置情報',
    'チャット',
    '逮捕',
  ];

  static const List<Widget> _routes = [
    HomePage(),
    MapPage(),
    ChatPage(),
    ArrestPage(),
  ];

  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems.add(_updateActiveState(0));
    for (var i = 1; i < _rootWidgetItemNames.length; i++) {
      _bottomNavigationBarItems.add(_updateDeactiveState(i));
    }
  }

  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _updateActiveState(int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        _rootWidgetIcons[index],
        color: Colors.black87,
      ),
      label: _rootWidgetItemNames[index],
    );
  }

  /// インデックスのアイテムをディアクティベートする
  BottomNavigationBarItem _updateDeactiveState(int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        _rootWidgetIcons[index],
        color: Colors.black26,
      ),
      label: _rootWidgetItemNames[index],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _updateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _updateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
