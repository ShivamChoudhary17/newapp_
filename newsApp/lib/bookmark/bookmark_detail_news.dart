import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:newsapp/news_detail/webpage.dart';
import 'operations.dart';

class BookMarkDetailNews extends StatefulWidget {
  late final String newsHead, newsImg, newsCont, newsUrl, id;
  late final DocumentSnapshot documentSnapshot;
  BookMarkDetailNews(
      {required this.newsHead,
      required this.documentSnapshot,
      required this.id,
      required this.newsImg,
      required this.newsCont,
      required this.newsUrl}) {}

  @override
  _BookMarkDetailNewsState createState() => _BookMarkDetailNewsState();
}

class _BookMarkDetailNewsState extends State<BookMarkDetailNews> {
  late String finalurl;
  late String id;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final document = parse(widget.newsCont);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "QuickNEWS",
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.of(context).pop()),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Scaffold(
            extendBody: true,
            body: Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListView(
                children: <Widget>[
                  const Align(
                    alignment: Alignment(-1.05, 1),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Hero(
                      tag: widget.newsImg,
                      child: Image.network(widget.newsImg)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 40),
                        child: ElevatedButton(
                          child: Icon(Icons.bookmark_remove),
                          onPressed: () {
                            deleteProduct(widget.documentSnapshot);
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8.0)),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    widget.newsHead,
                    style: GoogleFonts.zillaSlab(
                      color: Theme.of(context).accentColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    parsedString,
                    style: GoogleFonts.zillaSlab(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.open_in_new,
                    ),
                    label: Text(
                      "Read Full Story",
                    ),
                    onPressed: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (context) => WebPage(
                                newsUrl: widget.newsUrl,
                              )),
                    ),
                  ),
                ],
              ),
            )));
  }
}
