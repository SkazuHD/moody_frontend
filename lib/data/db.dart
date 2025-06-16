import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:Soullog/data/constants/emotions.dart';
import 'package:Soullog/data/models/record.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/plotCard.dart';

class RecordsDB {
  static RecordsDB? _instance;
  static bool _initialized = false;
  final _todaysPlotCard = BehaviorSubject<PlotCard?>();

  Stream<PlotCard?> get todaysPlotCardStream => _todaysPlotCard.stream;
  PlotCard emptyCard = PlotCard(
    mood: "Neutral",
    quote: "No mood recorded today.",
    recommendation: ["Take a moment to reflect"],
    date: DateTime.now(),
    isEmpty: true,
  );

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

  // Add DB scripts for future migrations here
  final migrations = <int, Future<void> Function(Database)>{2: (db) async => await Future.delayed(Duration.zero)};

  Future<void> _init() async {
    final String initScript =
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, filePath TEXT, duration INTEGER, createdAt TEXT, transcription TEXT, mood TEXT, isFastCheckIn BOOLEAN DEFAULT 0)';
    _db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: 1, // The Target version for the database
      onCreate: (db, version) {
        if (kDebugMode) {
          print('Database file created. Creating table $_tableName via onCreate.');
        }
        return db.execute(initScript);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (kDebugMode) {
          print('Database upgraded from version $oldVersion to $newVersion.');
        }
        for (int v = oldVersion + 1; v <= newVersion; v++) {
          final migration = migrations[v];
          if (migration != null) {
            await migration(db);
          }
        }
      },
    );

    if (kDebugMode) {
      var links = [
        "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3",
        "assets/amogus.mp3",
        "assets/Bread.mp3",
        "assets/Surprise.mp3",
        "assets/surprise2.mp3",
        "assets/test_recording.m4a",
        "assets/happier.mp3",
        "assets/happy.mp3",
        "assets/my_personal_favorite.mp3",
        "assets/cans_favorite.mp3",
      ];
      await _db!.transaction((txn) async {
        log('Debug Mode: Dropping and recreating table $_tableName in _init.');
        await txn.execute('DROP TABLE IF EXISTS $_tableName');
        await txn.execute(initScript);

        final batch = txn.batch();
        final int recordCount = 31;
        for (var i = 0; i < recordCount; i++) {
          final randomEmotion = Emotion.values[Random().nextInt(Emotion.values.length)];

          final record = Recording(
            filePath: links[Random().nextInt(links.length)],
            duration: Random().nextInt(60) + 1,
            createdAt: DateTime.now().subtract(Duration(days: i)),
            transcription: 'Sample transcription for recording $i.',
            mood: randomEmotion.label,
          );

          batch.insert(_tableName, record.toDbValuesMap(), conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit();

        if (kDebugMode) {
          print('Batch insert von $recordCount Datensätzen abgeschlossen');
        }
      });
    }

    if (kDebugMode) {
      print('Database initialization process completed in _init.');
    }
    // Load today's PlotCard if it exists
    await loadTodaysPlotCard();
  }

  Future<void> loadTodaysPlotCard() async {
    final store = await SharedPreferences.getInstance();
    store.remove('todaysPlotCard');
    final todaysCardString = store.getString('todaysPlotCard');
    if (todaysCardString != null) {
      var date = DateTime.now();
      try {
        final Map<String, dynamic> map = jsonDecode(todaysCardString);
        final todaysCard = PlotCard.fromMap(map);
        var plotcardDate = todaysCard.date;
        if (date.day != plotcardDate.day || date.month != plotcardDate.month || date.year != plotcardDate.year) {
          _todaysPlotCard.add(emptyCard);
          return;
        }
        _todaysPlotCard.add(todaysCard);
      } catch (e) {
        if (kDebugMode) {
          print('Error loading today\'s PlotCard: $e');
        }
        _todaysPlotCard.add(emptyCard);
      }
    } else {
      _todaysPlotCard.add(emptyCard);
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

  Future<int> insertRecord(Recording record) async {
    await _ensureInitialized();

    return await _db!.transaction((txn) async {
      if (kDebugMode) {
        print('Inserting record: ${record.toDbValuesMap()}');
      }

      int res = await txn.insert(_tableName, record.toDbValuesMap(), conflictAlgorithm: ConflictAlgorithm.replace);

      if (kDebugMode) {
        print('Inserted record with id: $res');
      }
      return res;
    });
  }

  Future<void> createTodaysPlotCard(PlotCard? card) async {
    if (card != null) {
      final store = await SharedPreferences.getInstance();
      store.setString('todaysPlotCard', jsonEncode(card.toJson()));
      _todaysPlotCard.add(card);
    }
  }

  Future<void> updateRecord(Recording record) async {
    await _ensureInitialized();

    await _db!.transaction((txn) async {
      if (kDebugMode) {
        print('Updating record: ${record.toJson()}');
      }

      await txn.update(_tableName, record.toJson(), where: 'id = ?', whereArgs: [record.id]);
    });
  }

  Future<Recording?> getRecord(int id) async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Fetching record with id: $id');
    }

    final List<Map<String, dynamic>> maps = await _db!.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Recording.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Recording>> getRecordsByDateRange(DateTime start, DateTime end) async {
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
      return Recording.fromJson(maps[i]);
    });
  }

  Future<List<Recording>> getRecords({String sort = "DESC", String orderBy = "createdAt"}) async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Fetching all records');
    }
    final List<Map<String, dynamic>> maps = await _db!.query(_tableName, orderBy: '$orderBy $sort');

    return List.generate(maps.length, (i) {
      return Recording.fromJson(maps[i]);
    });
  }

  Future<void> deleteRecord(int id) async {
    await _ensureInitialized();

    await _db!.transaction((txn) async {
      if (kDebugMode) {
        print('Deleting record with id: $id');
      }

      await txn.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<void> deleteRecords(List<Recording> records) async {
    await _ensureInitialized();

    await _db!.transaction((txn) async {
      if (kDebugMode) {
        print('Löschen von ${records.length} Aufzeichnungen mit IDs: ${records.map((r) => r.id).join(', ')}');
      }
      final batch = txn.batch();

      for (var record in records) {
        if (record.id != null) {
          batch.delete(_tableName, where: 'id = ?', whereArgs: [record.id]);
        }
      }

      await batch.commit();
    });
  }
}
