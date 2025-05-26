import 'package:Soullog/data/models/record.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

List<Recording> recordings = [
  Recording(
    id: 0,
    filePath: 'assets/audio/recording1.mp3',
    duration: 30,
    createdAt: DateTime.now().subtract(Duration(days: 0)),
    transcription: 'This is a sample transcription.',
    mood: 'calm',
  ),
  Recording(
    id: 1,
    filePath: 'assets/audio/recording1.mp3',
    duration: 30,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
    transcription: 'This is a sample transcription.',
    mood: 'happy',
  ),
  Recording(
    id: 2,
    filePath: 'assets/audio/recording2.mp3',
    duration: 12,
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    transcription: 'Another sample transcription.',
    mood: 'sad',
  ),
  // Add more recordings as needed
  Recording(
    id: 3,
    filePath: 'assets/audio/recording3.mp3',
    duration: 45,
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    transcription: 'This is another sample transcription.',
    mood: 'angry',
  ),
  Recording(
    id: 4,
    filePath: 'assets/audio/recording4.mp3',
    duration: 20,
    createdAt: DateTime.now().subtract(Duration(days: 4)),
    transcription: 'Yet another sample transcription.',
    mood: 'fear',
  ),
  Recording(
    id: 5,
    filePath: 'assets/audio/recording5.mp3',
    duration: 35,
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    transcription: 'Final sample transcription.',
    mood: 'calm',
  ),
  Recording(
    id: 6,
    filePath: 'assets/audio/recording5.mp3',
    duration: 35,
    createdAt: DateTime.now().subtract(Duration(days: 6)),
    transcription: 'Final sample transcription.',
    mood: 'angry',
  ),
  Recording(
    id: 7,
    filePath: 'assets/audio/recording5.mp3',
    duration: 35,
    createdAt: DateTime.now().subtract(Duration(days: 9)),
    transcription: 'Final sample transcription.',
    mood: 'angry',
  ),
  Recording(
    id: 8,
    filePath: 'assets/audio/recording5.mp3',
    duration: 35,
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    transcription: 'Final sample transcription.',
    mood: 'sad',
  ),
];

class RecordsDB {
  static RecordsDB? _instance;
  static bool _initialized = false;

  RecordsDB._internal();

  static Future<RecordsDB> getInstance() async {
    if (_instance == null) {
      _instance = RecordsDB._internal();
      await _instance!._init();
      _initialized = true;
    }
    return _instance!;
  }

  final String _databaseName = 'records.db';
  final String _tableName = 'records';
  Database? _db;

  Future<void> _init() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, filePath TEXT, duration INTEGER, createdAt TEXT, transcription TEXT, mood TEXT)',
        );
      },
      version: 1,
    );

    for (var record in recordings) {
      await insertRecord(record);
    }
  }

  Future<bool> _ensureInitialized() async {
    if (_db == null || !_initialized) {
      if (kDebugMode) {
        print('Database not initialized, initializing now...');
      }
      await getInstance();
    }
    return true;
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
    await _ensureInitialized();

    if (kDebugMode) {
      print('Inserting record: ${record.toJson()}');
    }
    await _db!.insert(
      _tableName,
      record.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateRecord(Recording record) async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Updating record: ${record.toJson()}');
    }

    await _db!.update(
      _tableName,
      record.toJson(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  Future<Recording?> getRecord(int id) async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Fetching record with id: $id');
    }

    final List<Map<String, dynamic>> maps = await _db!.query(
      _tableName,
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
    await _ensureInitialized();

    if (kDebugMode) {
      print('Fetching records between $start and $end');
    }

    final List<Map<String, dynamic>> maps = await _db!.query(
      _tableName,
      where: 'createdAt BETWEEN ? AND ?',
      orderBy: 'createdAt ASC',
      whereArgs: [start.toIso8601String(), end.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return mapToRecord(maps[i]);
    });
  }

  Future<List<Recording>> getRecords() async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Fetching all records');
    }
    final List<Map<String, dynamic>> maps = await _db!.query(_tableName);

    return List.generate(maps.length, (i) {
      return mapToRecord(maps[i]);
    });
  }

  Future<void> deleteRecord(int id) async {
    if (kDebugMode) {
      print('Deleting record with id: $id');
    }

    await _ensureInitialized();
    await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
