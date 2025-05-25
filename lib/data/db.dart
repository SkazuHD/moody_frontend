import 'package:moody_frontend/data/models/record.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    recordings;
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
