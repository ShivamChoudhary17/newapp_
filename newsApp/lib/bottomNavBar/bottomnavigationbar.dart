import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/search/searchpage.dart';
import '../notes/pages/home_note.dart';
import '../category/Cateogory.dart';
import '../pages/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int index = 1;
  final screen = [
    Cateogory('business'),
    const Home(),
    const SearchPage(),
    HomeNote()
  ];
  final items = [
    const Icon(Icons.info_outlined),
    const Icon(Icons.home_filled),
    const Icon(Icons.search),
    const Icon(Icons.note_add_rounded)
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      body: screen[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white)
        ),
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
