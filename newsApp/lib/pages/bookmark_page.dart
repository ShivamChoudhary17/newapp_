import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../bookmark/bookmark_detail_news.dart';

class BookmarkPage extends StatefulWidget {
  static const routeName = 'homePage';
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
            ),
            Text(
              "QuickNEWS",
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("newsdetails").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return !snapshot.hasData
              ? Text('No BookMarks')
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data?.docs.elementAt(index)
                        as DocumentSnapshot<Object?>;
                    try {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookMarkDetailNews(
                                          documentSnapshot: data,
                                          id: data.id,
                                          newsCont: data['discription'],
                                          newsUrl: data['url'],
                                          newsImg: data['_image'],
                                          newsHead: data['heading'],
                                        )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 1.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: FadeInImage(
                                      image: NetworkImage(data['_image']),
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
                                              BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black12.withOpacity(0),
                                              Colors.black
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          )),
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 10, 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['heading'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['discription'].length > 50
                                                ? "${data['discription'].substring(0, 50)}..."
                                                : data['discription'],
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
                  });
        },
      ),
    );
  }
}
