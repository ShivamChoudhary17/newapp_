import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:newsapp/news_detail/webpage.dart';
import '../bookmark/operations.dart';
import '../notes/views/createnoteview.dart';

class NewsWeb extends StatefulWidget {
  final String newsHead, newsImg, newsContent, newsUrl;
  NewsWeb(
      {required this.newsHead,
      required this.newsImg,
      required this.newsContent,
      required this.newsUrl});

  @override
  _NewsWebState createState() => _NewsWebState();
}

class _NewsWebState extends State<NewsWeb> {
  late String finalurl;
  late String id;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final document = parse(widget.newsContent);
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
                        padding: const EdgeInsets.only(top: 8.0, left: 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Icon(Icons.bookmark_add),
                          onPressed: () {
                            uploadingData(widget.newsContent, widget.newsHead,
                                widget.newsImg, widget.newsUrl, isFav);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Icon(Icons.note_add_rounded),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (context) => CreateNoteView()));
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