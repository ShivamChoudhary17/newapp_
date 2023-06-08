import 'package:flutter/material.dart';

import '../model/newsmodel.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toogleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  int _count = 0;
  List<NewsModel> items = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void addItems(NewsModel data) {
    items.add(data);
    notifyListeners();
  }

  int get count {
    return _count;
  }

  List<NewsModel> get itemsList {
    return items;
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
    backgroundColor: Colors.white10,
    accentColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.blueAccent),
    backgroundColor: Colors.white,
    accentColor: Colors.black,
  );
}
