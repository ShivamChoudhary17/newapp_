import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:ui';
import '../../auth_/auth.dart';
import '../../auth_/login.dart';
import '../../auth_/login_info.dart';
import '../../theme/changethemebutton.dart';
import '../model/my_note_model.dart';
import '../search/SearchPage.dart';
import '../views/noteview.dart';
import '../views/createnoteview.dart';
import '../side_drawer/sidemenubar.dart';
import '../color/colors.dart';
import '../services/db.dart';


class HomeNote extends StatefulWidget {
  const HomeNote({Key? key}) : super(key: key);

  @override
  _HomeNote createState() => _HomeNote();
}

class _HomeNote extends State<HomeNote> {
  bool isLoading = true;
  late List<Note> notesList;
  late String? imgUrl;
  bool isStaggered = true;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    LocalDataSaver.saveSyncSet(false);
    getAllNotes();
  }

  // CREATE NEW NOTE IN DATABASE
  Future createEntry(Note note) async {
    await NotesDatabase.instance.insertEntry(note);
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

    notesList = await NotesDatabase.instance.readAllNotes();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getOneNote(int id) async {
    await NotesDatabase.instance.readOneNote(id);
  }

  Future updateOneNote(Note note) async {
    await NotesDatabase.instance.updateNote(note);
  }

  Future deleteNote(Note note) async {
    await NotesDatabase.instance.deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? 'DarkTheme' : 'LightTheme';
    return isLoading
        ? Scaffold(
            appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          "QuickNEWS",
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        centerTitle: true,
        backgroundColor: bgColor,
        elevation: 0,
      ),
            backgroundColor: bgColor,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            "QuickNEWS",
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          centerTitle: true,
          backgroundColor: bgColor,
          elevation: 0,
        ),
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
                size: 50,
              ),
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            //drawer: const SideMenu(),
            backgroundColor: bgColor,
            body: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  /// adding elements in list after [1 seconds] delay
                  /// to mimic network call
                  ///
                  /// Remember: [setState] is necessary so that
                  /// build method will run again otherwise
                  /// list will not show all elements
                  setState(() {});
                });
              },
              child: SafeArea(
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
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        _drawerKey.currentState!.openDrawer();
                                      },
                                      icon: const Icon(
                                        Icons.menu,
                                        color: white,
                                      )),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SearchView()));
                                    },
                                    child: SizedBox(
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                220,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Search Your Notes",
                                                style: TextStyle(
                                                    color:
                                                        white.withOpacity(0.5),
                                                    fontSize: 14),
                                              )
                                            ])),
                                  )
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        onPressed: () {
                                          setState(() {
                                            isStaggered = !isStaggered;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.grid_view,
                                          color: white,
                                        )),
                                    const SizedBox(
                                      width: 9,
                                    ),
                                    /*  SIGN OUT  */
                                    GestureDetector(
                                      onTap: () {
                                        signOut();
                                        LocalDataSaver.saveLoginData(false);

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const
                                                Login()));
                                      },
                                      child: CircleAvatar(
                                        //AVATAR
                                        onBackgroundImageError:
                                            (Object, StackTrace) {
                                          print("Ok");
                                        },
                                        radius: 16,
                                        backgroundImage:
                                            NetworkImage(imgUrl.toString()),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ])),
                    isStaggered ? noteSectionAll() : notesListSection()
                  ],
                ),
              )),
            ));
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
                                builder: (context) =>
                                    NoteView(note: notesList[index])));
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
                                style: const TextStyle(
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

  Widget notesListSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "ALL",
                  style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
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
              itemCount: notesList.length,
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // DISPLAY TITLE OF NOTE
                    Text(notesList[index].title,
                        style: const TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      // DISPLAY CONTENT OF NOTE
                      notesList[index].content.length > 250
                          ? "${notesList[index].content.substring(0, 250)}..."
                          : notesList[index].content,
                      style: const TextStyle(color: white),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
