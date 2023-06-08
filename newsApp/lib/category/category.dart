import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import '../model/newsmodel.dart';
import '../pages/newsdetails.dart';

class Category extends StatefulWidget {
  String Query = "";
  Category({Key? key, required this.Query}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<NewsModel> newsModelList = <NewsModel>[];
  bool isLoading = true;
  String url = "";

  getNews(String query) async {
    Map element;
    if (query == "Top News" || query == "india") {
      url = "https://newsapi.org/v2/top-headlines?language=en&category=$query"
          "&apiKey"
          "=3d44e64c78a94ed58931cec839a62219";
    } else {
      url = "https://newsapi.org/v2/top-headlines?language=en&category=$query&apiKey=3d44e64c78a94ed58931cec839a62219";
    }
//https://newsapi.org/v2/top-headlines?language=en&category=$query&apiKey=3d44e64c78a94ed58931cec839a62219
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          NewsModel newsModel = NewsModel();
          newsModel = NewsModel.fromMap(element);
          newsModelList.add(newsModel);
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

  searchNews(String query) async {
    Map element;
    if (query == "Top News" || query == "india") {
      url = "http://newsapi"
          ".org/v2/everything?q=$query&3d44e64c78a94ed58931cec839a62219";
    } else {
      url = "http://newsapi"
          ".org/v2/everything?q=$query&3d44e64c78a94ed58931cec839a62219";
    }
//https://newsapi.org/v2/top-headlines?language=en&category=$query&apiKey=3d44e64c78a94ed58931cec839a62219
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          NewsModel newsModel = NewsModel();
          newsModel = NewsModel.fromMap(element);
          newsModelList.add(newsModel);
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews(widget.Query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 5, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    widget.Query,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 39),
                  ),
                ],
              ),
            ),
            isLoading
                ? CircularProgressIndicator(color: Colors.red)
                : Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsModelList.length,
                        itemBuilder: (context, index) {
                          try {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsWeb(
                                                newsContent:
                                                    newsModelList[index]
                                                        .newsContent,
                                                newsUrl: newsModelList[index]
                                                    .newsUrl,
                                                newsImg: newsModelList[index]
                                                    .newsImg,
                                                newsHead: newsModelList[index]
                                                    .newsHead,
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 1.0,
                                  child: Stack(
                                    children: [
                                      /*
                                      newsModelList[index]
                                              .newsImg.contains('"https')
                                          ? */
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            newsModelList[index].newsImg,
                                            fit: BoxFit.cover,
                                            height: 300,
                                            width: double.infinity,
                                          )),
                                      /*: Container(
                                        height: 300,
                                        width: double.infinity,decoration:
                                  BoxDecoration(
                                    color: Colors.white
                                  ),*/

                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12
                                                        .withOpacity(0),
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                )),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 10, 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newsModelList[index].newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  newsModelList[index]
                                                              .newsDes
                                                              .length >
                                                          40
                                                      ? "${newsModelList[index].newsDes.substring(0, 50)}..."
                                                      : newsModelList[index]
                                                          .newsDes,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } catch (e) {
                            return Container();
                          }
                        },
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            color: Colors.lightGreen,
                            size: 55,
                          )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Text(
                          "You'r All Caught Up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Text(
                          "For Now",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
