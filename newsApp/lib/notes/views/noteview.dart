import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../bottomNavBar/bottomnavigationbar.dart';
import 'editnoteview.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../color/colors.dart';
import '../services/db.dart';
import '../../pages/home_note.dart';
import '../model/my_note_model.dart';

class NoteView extends StatefulWidget {
  final Note? note;
  NoteView({required this.note});

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await NotesDatabase.instance.pinNote(widget.note);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
              },
              icon: Icon(
                  widget.note!.pin ? Icons.push_pin : Icons.push_pin_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await NotesDatabase.instance.archNote(widget.note);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar()));
              },
              icon: Icon(widget.note!.isArchive
                  ? Icons.archive
                  : Icons.archive_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                await NotesDatabase.instance.deleteNote(widget.note);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
              icon: const Icon(Icons.delete_forever_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditNoteView(note: widget.note)));
              },
              icon: const Icon(Icons.edit_outlined))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Created On ${DateFormat('dd-MM-yyyy - kk:mm').format(widget.note!.createdTime)}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.note!.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.note!.content,
              style: const TextStyle(color: Colors.white),
            )
          ]),
        ),
      ),
    );
  }
}
