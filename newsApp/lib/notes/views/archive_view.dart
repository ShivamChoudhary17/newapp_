import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../auth_/login_info.dart';
import '../../pages/home.dart';
import '../model/my_note_model.dart';
import '../services/db.dart';
import 'NoteView.dart';
import 'createnoteview.dart';
import 'package:flutter/material.dart';
import '../side_drawer/sidemenubar.dart';
import '../color/colors.dart';

class ArchiveView extends StatefulWidget {
  const ArchiveView({Key? key}) : super(key: key);

  @override
  _ArchiveViewState createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool isLoading = true;
  late List<Note> notesList;
  late String? imgUrl;
  String note =
      "THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE";
  String note1 = "THIS IS NOTE THIS IS NOTE THIS IS NOTE";

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  Future getAllNotes() async {
    LocalDataSaver.getImg().then((value) {
      // This basically means the state can't be updated and setState can no '
      // 'longer be called. So when you check if a widget is mounted, you're
      // checking if its state can still be updated
      if (mounted) {
        setState(() {
          imgUrl = value;
        });
      }
    });

    notesList = await NotesDatabase.instance.readAllArchiveNotes();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            backgroundColor: bgColor,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
            /* ADDING NEW NOTE */
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateNoteView()));
              },
              backgroundColor: cardColor,
              child: const Icon(
                Icons.add,
                size: 45,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: const SideMenu(),
            backgroundColor: bgColor,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3)
                          ]),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /* MENU & SEARCH */
                            Row(
                              children: [
                                /* MENU ICON */
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: white,
                                    )),
                                const SizedBox(
                                  width: 16,
                                ),
                                /* SEARCH NOTE ICON */
                                SizedBox(
                                    height: 55,
                                    width: 200,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        //crossAxisAlignment:
                                        //  CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Search Your Notes",
                                            style: TextStyle(
                                                color: white.withOpacity(0.5),
                                                fontSize: 16),
                                          )
                                        ]))
                              ],
                            ),
                            /*Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) =>
                                                  white.withOpacity(0.1)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ))),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.grid_view,
                                    color: white,
                                  )),
                              const SizedBox(
                                width: 9,
                              ),
                              const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.white,
                              )
                            ],
                          ),
                        ),*/
                          ])),
                  noteSectionAll(),
                  /*notesListSection()*/
                ],
              ),
            )));
  }

  Widget noteSectionAll() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "ALL",
                style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: StaggeredGridView.countBuilder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: notesList.length,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                crossAxisCount: 4,
                staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoteView(
                                      note: notesList[index],
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: white.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notesList[index].title,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              notesList[index].content.length > 250
                                  ? "${notesList[index].content.substring(0, 250)}..."
                                  : notesList[index].content,
                              style: const TextStyle(color: white),
                            )
                          ],
                        ),
                      ),
                    ))),
      ],
    );
  }
/*
  Widget notesListSection() {
    return Column(
      children: [
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "LIST VIEW",
            style: TextStyle(
                color: white.withOpacity(0.5),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border.all(color: white.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("HEADING",
                    style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  index.isEven
                      ? note.length > 250
                          ? "${note.substring(0, 250)}..."
                          : note
                      : note1,
                  style: const TextStyle(color: white),
                )
              ],
            ),
          ),
        )),
      ],
    );
  }*/
}
