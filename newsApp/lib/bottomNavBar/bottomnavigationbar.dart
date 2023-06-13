import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/searchpage.dart';
import '../pages/bookmark_page.dart';
import '../pages/home_note.dart';
import '../pages/Cateogory.dart';
import '../pages/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 1;
  final screen = [
    Cateogory(),
    Home(),
    SearchPage(),
    BookmarkPage(),
    HomeNote(),
  ];
  final items = [
    const Icon(Icons.more_horiz_sharp),
    const Icon(Icons.home_filled),
    const Icon(Icons.search),
    const Icon(Icons.bookmark),
    const Icon(Icons.note_add_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screen[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Theme.of(context).primaryColor,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          height: 42,
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
