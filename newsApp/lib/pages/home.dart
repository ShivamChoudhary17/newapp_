import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import '../auth_/auth.dart';
import '../auth_/login.dart';
import '../auth_/login_info.dart';
import '../notes/color/colors.dart';
import '../theme/changethemebutton.dart';
import '../model/categorymodel.dart';
import '../model/model.dart';
import '../model/newsmodel.dart';
import '../news_detail/newsdetails.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    LocalDataSaver.saveSyncSet(false);
    getAllNotes();
    getNews();
    getNewsOfIndia();

    categories = getCategories();
  }

  String? imgUrl;
  TextEditingController searchController = TextEditingController();
  List<NewsModel> newsModelList = <NewsModel>[];
  List<NewsModel> newsModelListCarousel = <NewsModel>[];
  List<CategorieModel> categories = <CategorieModel>[];
  bool isLoading = true;

  Future getAllNotes() async {
    LocalDataSaver.getImg().then((value) {
      if (mounted) {
        setState(() {
          imgUrl = value;
        });
      }
    });
  }

  getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=politics&sortBy=publishedAt&apiKey=3d44e64c78a94ed58931cec839a62219";
    Response response = await get(Uri.parse(url));
    Map element;
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          //i++;
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

  getNewsOfIndia() async {
    Map element;
    String url =
        "https://newsapi.org/v2/top-headlines?language=en&country=in&apiKey"
        "=3d44e64c78a94ed58931cec839a62219";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      for (element in data["articles"]) {
        try {
          NewsModel newsQueryModel = NewsModel();
          newsQueryModel = NewsModel.fromMap(element);
          newsModelListCarousel.add(newsQueryModel);
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
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
            extendBody: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      signOut();
                      LocalDataSaver.saveLoginData(false);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: CircleAvatar(
                      //AVATAR
                      onBackgroundImageError: (Object, StackTrace) {
                        print("Ok");
                      },
                      radius: 16,
                      backgroundImage: NetworkImage(imgUrl.toString()),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    "QuickNEWS",
                    style: TextStyle(color: Theme.of(context).iconTheme.color),
                  )
                ],
              ),
              actions: [
                ChangeThemeButtonWidget(),
              ],
              centerTitle: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
            ),
            //Body Container
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 9.0),
                child: Column(
                  children: [
                    //carousel_slider
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: 250,
                            autoPlay: true,
                            enlargeCenterPage: true),
                        items: newsModelListCarousel.map((instance) {
                          return Builder(builder: (BuildContext context) {
                            try {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsWeb(
                                                newsContent:
                                                    instance.newsContent,
                                                newsUrl: instance.newsUrl,
                                                newsImg: instance.newsImg,
                                                newsHead: instance.newsHead,
                                              )));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage(
                                              image: NetworkImage(
                                                  instance.newsImg),
                                              placeholder: const AssetImage(
                                                  'images/loading.jpg'))),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black12
                                                        .withOpacity(0),
                                                    Colors.black
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                )),
                                            child: Text(instance.newsHead,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white))),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } catch (e) {
                              return const Card();
                            }
                          });
                        }).toList(),
                      ),
                    ),

                    /*-- Latest News Section --*/

                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("🔴"),
                              const SizedBox(width: 8),
                              Text(
                                "Latest News",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: newsModelList.length,
                              itemBuilder: (context, index) {
                                try {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => NewsWeb(
                                                      newsContent:
                                                          newsModelList[index]
                                                              .newsContent,
                                                      newsUrl:
                                                          newsModelList[index]
                                                              .newsUrl,
                                                      newsImg:
                                                          newsModelList[index]
                                                              .newsImg,
                                                      newsHead:
                                                          newsModelList[index]
                                                              .newsHead,
                                                    )));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        elevation: 1.0,
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage(
                                                  image: NetworkImage(
                                                      newsModelList[index]
                                                          .newsImg),
                                                  placeholder: const AssetImage(
                                                      'images/loading.jpg'),
                                                )),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black12
                                                              .withOpacity(0),
                                                          Colors.black
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      )),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 15, 10, 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        newsModelList[index]
                                                            .newsHead,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        newsModelList[index]
                                                                    .newsDes
                                                                    .length >
                                                                50
                                                            ? "${newsModelList[index].newsDes.substring(0, 50)}..."
                                                            : newsModelList[
                                                                    index]
                                                                .newsDes,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
