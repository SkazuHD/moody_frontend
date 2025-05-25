import 'package:moody_frontend/data/models/record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

List<Recording> recordings = [
  Recording(
    id: 1,
    filePath: 'assets/audio/recording1.mp3',
    duration: 30,
    createdAt: DateTime.now(),
    transcription: 'This is a sample transcription.',
    mood: 'Happy',
  ),
  Recording(
    id: 2,
    filePath: 'assets/audio/recording2.mp3',
    duration: 12,
    createdAt: DateTime.now(),
    transcription: 'Another sample transcription.',
    mood: 'Sad',
  ),
  // Add more recordings as needed
  Recording(
    id: 3,
    filePath: 'assets/audio/recording3.mp3',
    duration: 45,
    createdAt: DateTime.now(),
    transcription: 'This is another sample transcription.',
    mood: 'Angry',
  ),
  Recording(
    id: 4,
    filePath: 'assets/audio/recording4.mp3',
    duration: 20,
    createdAt: DateTime.now(),
    transcription: 'Yet another sample transcription.',
    mood: 'Surprised',
  ),
  Recording(
    id: 5,
    filePath: 'assets/audio/recording5.mp3',
    duration: 35,
    createdAt: DateTime.now(),
    transcription: 'Final sample transcription.',
    mood: 'Neutral',
  ),
];

class RecordsDB {
  static final RecordsDB _instance = RecordsDB._internal();

  factory RecordsDB() {
    return _instance;
  }

  RecordsDB._internal() {
    init();
  }

  final String databaseName = 'records.db';
  final String tableName = 'records';

  Database? db;

  void init() async {
    db = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, filePath TEXT, duration INTEGER, createdAt TEXT, transcription TEXT, mood TEXT)',
        );
      },
      version: 1,
    );
    for (var record in recordings) {
      await insertRecord(record);
    }
  }

  Recording mapToRecord(Map<String, dynamic> map) {
    return Recording(
      id: map['id'],
      filePath: map['filePath'],
      duration: map['duration'],
      createdAt: DateTime.parse(map['createdAt']),
      transcription: map['transcription'],
      mood: map['mood'],
    );
  }

  Future<void> insertRecord(Recording record) async {
    if (db == null) return;
    await db!.insert(
      tableName,
      record.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRecord(Recording record) async {
    if (db == null) return;
    await db!.update(
      tableName,
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<Recording?> getRecord(int id) async {
    if (db == null) return null;
    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return mapToRecord(maps.first);
    }
    return null;
  }

  Future<List<Recording>> getRecordsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: 'createdAt BETWEEN ? AND ?',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return mapToRecord(maps[i]);
    });
  }

  Future<List<Recording>> getRecords() async {
    if (db == null) return [];
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (i) {
      return mapToRecord(maps[i]);
    });
  }

  Future<void> deleteRecord(int id) async {
    if (db == null) return;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
