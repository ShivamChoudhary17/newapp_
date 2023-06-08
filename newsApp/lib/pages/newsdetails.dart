import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:newsapp/pages/webpage.dart';
import 'package:provider/provider.dart';
import '../theme/theme.dart';

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


  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<ThemeProvider>(context);
    final document = parse(widget.newsContent);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "QuickNEWS",
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
              onPressed: () => Navigator.of(context).pop()),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Scaffold(
            body: Padding(
              padding:  const EdgeInsets.all(14.0),
              child: ListView(
                children: <Widget>[
                  const Align(
                    alignment: Alignment(-1.05, 1),),
                  const SizedBox(height: 18.0,),
                  Hero(tag: widget.newsImg, child: Image.network(widget.newsImg)),
                  const Padding(padding: EdgeInsets.only(top: 8.0)),
                  const SizedBox(height: 18.0,),
                  Text(
                    widget.newsHead,
                    style: GoogleFonts.zillaSlab(
                      color: Theme.of(context).accentColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18.0,),
                  Text(
                    parsedString,
                    style: GoogleFonts.zillaSlab(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40.0,),
                  ElevatedButton.icon(
                    icon: Icon(Icons.open_in_new, color: Theme.of(context).iconTheme.color),
                    label: Text("Read Full Story", style: TextStyle(color: Theme
                        .of(context).iconTheme.color),),
                    onPressed: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                          builder: (context) => WebPage(newsUrl: widget.newsUrl,)
                      ),
                    ),
                  ),
                ],
              ),
            ))
    );





















  }
}











/*
*
* Scaffold(
            body: Padding(
          padding:  const EdgeInsets.all(14.0),
          child: ListView(
            children: <Widget>[
              const Align(
                  alignment: Alignment(-1.05, 1),),
              const SizedBox(height: 18.0,),
              Hero(tag: widget.newsImg, child: Image.network(widget.newsImg)),
              const Padding(padding: EdgeInsets.only(top: 8.0)),
              const SizedBox(height: 18.0,),
              ElevatedButton(onPressed: () {}, child: Text("add")),
              Text(
                widget.newsHead,
                style: GoogleFonts.zillaSlab(
                  color: Theme.of(context).accentColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18.0,),
              Text(
                parsedString,
                style: GoogleFonts.zillaSlab(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 40.0,),
              ElevatedButton.icon(
                icon: Icon(Icons.open_in_new, color: Theme.of(context).iconTheme.color),
                label: Text("Read Full Story", style: TextStyle(color: Theme
                        .of(context).iconTheme.color),),
                onPressed: () => Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => WebPage(newsUrl: widget.newsUrl,)
                  ),
                ),
              ),
            ],
          ),
        ))
* */
