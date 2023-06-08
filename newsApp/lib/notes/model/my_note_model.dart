// FORMAT OF FILE SAVED INTO SQL LITE DATABASE

class NotesImpNames {
  static const String id = "id";
  static const String uniqueID = "uniqueID";
  static const String pin = "pin";
  static const String title = "title";
  static const String content = "content";
  static const String isArchive = "isArchive";
  static const String createdTime = "createdTime";
  static const String tableName = "Notes";
  static final List<String> values = [
    id,
    isArchive,
    pin,
    title,
    content,
    createdTime
  ];
}

class Note {
  final int? id;
  final bool pin;
  final bool isArchive;
  final String title;
  final String? uniqueID;
  final String content;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.pin,
    required this.isArchive,
    required this.title,
    required this.content,
    required this.uniqueID,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? pin,
    bool? isArchieve,
    String? title,
    String? content,
    String? uniqueID,
    DateTime? createdTime,
  }) {
    return Note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        isArchive: isArchieve ?? isArchive,
        title: title ?? this.title,
        content: content ?? this.content,
        uniqueID: uniqueID ?? this.uniqueID,
        createdTime: createdTime ?? this.createdTime);
  }

  static Note fromJson(Map<String, Object?> json) {
    return Note(
        id: json[NotesImpNames.id] as int?,
        pin: json[NotesImpNames.pin] == 1,
        isArchive: json[NotesImpNames.isArchive] == 1,
        title: json[NotesImpNames.title] as String,
        content: json[NotesImpNames.content] as String,
        uniqueID: json[NotesImpNames.uniqueID] as String?,
        createdTime:
            DateTime.parse(json[NotesImpNames.createdTime] as String));
     //DateFormat('dd-MM-yyyy - kk:mm').format(widget.note!.createdTime);
  }

  Map<String, Object?> toJson() {
    return {
      NotesImpNames.id: id,
      NotesImpNames.pin: pin ? 1 : 0,
      NotesImpNames.isArchive: isArchive ? 1 : 0,
      NotesImpNames.title: title,
      NotesImpNames.uniqueID: uniqueID,
      NotesImpNames.content: content,
      NotesImpNames.createdTime: createdTime.toIso8601String()
    };
  }
}
