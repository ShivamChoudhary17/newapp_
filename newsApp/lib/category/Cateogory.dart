import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newsapp/category/categorycard.dart';
import 'package:newsapp/model/categorymodel.dart';
import 'package:newsapp/model/model.dart';

class Cateogory extends StatefulWidget {
  final setcategory;
  Cateogory(this.setcategory);
  @override
  _CateogoryState createState() => _CateogoryState(this.setcategory);
}

class _CateogoryState extends State<Cateogory> {
  var setcategory;
  _CateogoryState(this.setcategory);
  spin() {
    return SpinKitRotatingPlain(color: Colors.red);
  }

  var data;
  var url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=2d876e297540454b908c7258890cb059";
  Future getjsondata() async {
    var response = await http.get(url as Uri);
    if (mounted) {
      setState(() {
        var convertdata = json.decode(response.body);
        data = convertdata;
        print(data);
      });
    }
  }

  List<CategorieModel> categories = <CategorieModel>[];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "QuickNEWS",
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imageAssetUrl: categories[index].imageAssetUrl,
                        categoryName: categories[index].categorieName,
                      );
                    },
                  ),
                ),
              ],
            ))
        /*CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imageAssetUrl: categories[index].imageAssetUrl,
                        categoryName: categories[index].categorieName,
                      );
                    },
                  ),
                ),
                  Column(
                    children: [
                      space("images/world.jpeg", "All Current News", ""),
                      space("images/bussness.jpeg", "Business", "business"),
                      space("images/sports.jpeg", "Sports", "sports"),
                      space("images/entertainment.jpeg", "Entertainment",
                          "entertainment"),
                      space("images/technology.jpeg", "Technology", "technology"),
                      space("images/health.jpeg", "Health", "health"),
                    ],
                  )


              ]),
            ),
          ],
        )*/
        );
  }
}
