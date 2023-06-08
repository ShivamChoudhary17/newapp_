import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth_/login_info.dart';
import 'db.dart';
import '../model/my_note_model.dart';

class FireDB {
  //CREATE,READ,UPDATE,DELETE
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createNewNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSet().then((isSyncOn) async {
      if (isSyncOn.toString() == "true") {
        final User? currentUser = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(currentUser!.email)
            .collection("usernotes")
            .doc(note.uniqueID)
            .set({
          "Title": note.title,
          "content": note.content,
          "date": note.createdTime,
          "uniqueID": note.uniqueID,
        }).then((_) {
          print("DATA ADDED SUCCESSFULLY");
        });
      }
    });
  }

  getAllStoredNotes() async {
    final User? currentUser = _auth.currentUser;
    await FirebaseFirestore.instance
        .collection("notes")
        .doc(currentUser!.email)
        .collection("usernotes")
        .orderBy("date")
        .get()
        .then((querySnapshot) {
         for (var result in querySnapshot.docs) {
        Map note = result.data();

        NotesDatabase.instance.insertEntry(Note(
            title: note["Title"],
            content: note["content"],
            uniqueID: note["uniqueID"],
            createdTime: note["date"].toDate(),
            pin: false,
            isArchive: false)); //Add Notes In Database
      }});
  }

  updateNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSet().then((isSyncOn) async {
      if (isSyncOn.toString() == "true") {
        final User? currentUser = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(currentUser!.email)
            .collection("usernotes")
            .doc(note.uniqueID.toString())
            .update({
          "title": note.title.toString(),
          "content": note.content
        }).then((_) {
          print("DATA ADDED SUCCESSFULLY");
        });
      }
    });
  }

  deleteNoteFirestore(Note note) async {
    LocalDataSaver.getSyncSet().then((isSyncOn) async {
      if (isSyncOn.toString() == "true") {
        final User? currentUser = _auth.currentUser;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(currentUser!.email.toString())
            .collection("usernotes")
            .doc(note.uniqueID.toString())
            .delete()
            .then((_) {
          print("DATA DELETED SUCCESS FULLY");
        });
      }
    });
  }
}
