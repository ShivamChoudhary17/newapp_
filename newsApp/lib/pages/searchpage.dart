import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bottomNavBar/bottomnavigationbar.dart';
import '../category/category.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<String> navBarItem = [
    "Business",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style:
              TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 20),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const BottomNavBar()))),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(fit: StackFit.loose, children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(24)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if ((searchController.text.toLowerCase()) == "") {
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  Query: searchController.text.toLowerCase(),
                                )));
                  }
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                  child: Icon(CupertinoIcons.doc_text_search,
                      weight: 16, color: Colors.black),
                ),
              ),
              Expanded(
                  child: TextField(
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Category(Query: value)));
                },
                decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black),
                    hintText: "Search Category",
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i in navBarItem)
                  Text(i,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 22,
                          fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        )
      ]),
    );
  }
}
