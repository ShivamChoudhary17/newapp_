import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'firestore_db.dart';
import '../model/my_note_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  static Database? _database; // sql lite database
  NotesDatabase._init();

  // initialize NEW DATABASE
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initializeDB('NewNotes.db');
    return _database;
  }

  Future<Database> _initializeDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // CREATING NEW DATABASE AND ITS FORMAT TO STORE
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = ' BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE Notes(
      ${NotesImpNames.id} $idType,
      ${NotesImpNames.uniqueID} $textType,
      ${NotesImpNames.pin} $boolType,
      ${NotesImpNames.isArchive} $boolType,
      ${NotesImpNames.title} $textType,
      ${NotesImpNames.content} $textType,
      ${NotesImpNames.createdTime} $textType
  
    )
    ''');
  }

  // INSERTING NEWLY CREATED DB
  Future<Note?> insertEntry(Note note) async {
    final db = await instance.database;
    final id = await db!.insert(NotesImpNames.tableName, note.toJson());
    await FireDB().createNewNoteFirestore(note);
    return note.copy(id: id);
  }

  // READING DB
  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NotesImpNames.createdTime} ASC';
    final queryResult =
        await db!.query(NotesImpNames.tableName, orderBy: orderBy);
    return queryResult.map((json) => Note.fromJson(json)).toList();
  }

  // READING ARCHIVE NOTES
  Future<List<Note>> readAllArchiveNotes() async {
    final db = await instance.database;
    const orderBy = '${NotesImpNames.createdTime} ASC';
    final queryResult = await db!.query(NotesImpNames.tableName,
        orderBy: orderBy, where: '${NotesImpNames.isArchive} = 1');
    return queryResult.map((json) => Note.fromJson(json)).toList();
  }

  // READING ONE NOTE
  Future<Note?> readOneNote(int id) async {
    final db = await instance.database;
    final map = await db!.query(NotesImpNames.tableName,
        columns: NotesImpNames.values,
        where: '${NotesImpNames.id} = ?',
        whereArgs: [id]);
    if (map.isNotEmpty) {
      return Note.fromJson(map.first);
    } else {
      return null;
    }
  }

  // UPDATING NOTE
  Future updateNote(Note note) async {
    await FireDB().updateNoteFirestore(note);
    final db = await instance.database;

    await db!.update(NotesImpNames.tableName, note.toJson(),
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  // PIN NOTE
  Future pinNote(Note? note) async {
    final db = await instance.database;

    await db!.update(
        NotesImpNames.tableName, {NotesImpNames.pin: !note!.pin ? 1 : 0},
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  // ARCHIVE NOTE
  Future archNote(Note? note) async {
    final db = await instance.database;

    await db!.update(NotesImpNames.tableName,
        {NotesImpNames.isArchive: !note!.isArchive ? 1 : 0},
        where: '${NotesImpNames.id} = ?', whereArgs: [note.id]);
  }

  Future<List<int>> getNoteString(String query) async {
    final db = await instance.database;
    final result = await db!.query(NotesImpNames.tableName);
    List<int> resultIds = [];
    for (var element in result) {
      if (element["title"].toString().toLowerCase().contains(query) ||
          element["content"].toString().toLowerCase().contains(query)) {
        resultIds.add(element["id"] as int);
      }
    }

    return resultIds;
  }

  // DELETE NOTE
  Future deleteNote(Note? note) async {
    await FireDB().deleteNoteFirestore(note!);
    final db = await instance.database;

    await db!.delete(NotesImpNames.tableName,
        where: '${NotesImpNames.id}= ?', whereArgs: [note.id]);
  }

  // CLOSING DB
  Future closeDB() async {
    final db = await instance.database;
    db!.close();
  }
}
