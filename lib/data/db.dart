import 'dart:math';

import 'package:Soullog/data/constants/emotions.dart';
import 'package:Soullog/data/models/record.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/plotCard.dart';

List<PlotCard> plotCards = [
  PlotCard(
    mood: 'happy',
    title: 'Spread the Joy',
    description: 'Send a kind message or compliment to someone today. Let your happiness ripple out.',
    date: DateTime.now(),
  ),
  PlotCard(
    mood: 'sad',
    title: 'Small Step Forward',
    description: 'Put on comfy shoes and go outside for a 10-minute walk. No goal, just move.',
    date: DateTime.now(),
  ),
  PlotCard(
    mood: 'angry',
    title: 'Release the Pressure',
    description: 'Find a quiet spot and write down everything that’s bothering you. No filter, just let it out.',
    date: DateTime.now(),
  ),
  PlotCard(
    mood: 'calm',
    title: 'Deepen the Peace',
    description: 'Take a walk in the forest without a route. Let your mind wander and your breath slow down.',
    date: DateTime.now(),
  ),
  PlotCard(
    mood: 'fear',
    title: 'Brave Little Step',
    description: 'Write down one thing that scares you—and then list three things you can do anyway.',
    date: DateTime.now(),
  ),
];

class RecordsDB {
  static RecordsDB? _instance;
  static bool _initialized = false;
  PlotCard? _todaysPlotCard;

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
    final String initScript =
        'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, filePath TEXT, duration INTEGER, createdAt TEXT, transcription TEXT, mood TEXT)';
    _db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        if (kDebugMode) {
          print('Database file created. Creating table $_tableName via onCreate.');
        }
        return db.execute(initScript);
      },
      version: 1,
    );

    if (kDebugMode) {
      print('Debug Mode: Dropping and recreating table $_tableName in _init.');
      await _db!.execute('DROP TABLE IF EXISTS $_tableName');
      await _db!.execute(initScript);
      await _db!.transaction((txn) async {
        final batch = txn.batch();
        final int recordCount = 250;
        for (var i = 0; i < recordCount; i++) {
          final randomEmotion = Emotion.values[Random().nextInt(Emotion.values.length)];

          final record = Recording(
            filePath: 'assets/audio/recording$i.mp3',
            duration: Random().nextInt(60) + 1,
            createdAt: DateTime.now().subtract(Duration(days: i)),
            transcription: 'Sample transcription for recording $i.',
            mood: randomEmotion.label,
          );

          batch.insert(_tableName, record.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit();

        if (kDebugMode) {
          print('Batch insert von 60 Datensätzen abgeschlossen');
        }
      });
    }

    _initialized = true;
    if (kDebugMode) {
      print('Database initialization process completed in _init.');
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
      print('Inserting record: ${record.toDbValuesMap()}');
    }
    await _db!.insert(_tableName, record.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    // Automatically create today's PlotCard if mood is set and record is from today
    final now = DateTime.now();
    final isToday =
        record.createdAt.year == now.year && record.createdAt.month == now.month && record.createdAt.day == now.day;
    if (isToday) {
      if (isToday && record.mood != null) {
        await createTodaysPlotCard(record.mood!);
      }
    }
  }

  Future<void> createTodaysPlotCard(String mood) async {
    try {
      // Filter all PlotCards that match the mood
      final matchingCards = plotCards.where((c) => c.mood == mood).toList();
      if (matchingCards.isNotEmpty) {
        final randomIndex = Random().nextInt(matchingCards.length);
        final chosen = matchingCards[randomIndex]; // Select a random PlotCard
        _todaysPlotCard = PlotCard(
          mood: mood,
          title: chosen.title,
          description: chosen.description,
          date: DateTime.now(),
        );
      } else {
        if (kDebugMode) print("No PlotCard found for mood '$mood'.");
      }
    } catch (e) {
      if (kDebugMode) print("Oops, something went wrong while picking a PlotCard for mood '$mood': $e");
    }
  }

  Future<PlotCard?> getTodaysPlotCard() async {
    final now = DateTime.now();

    // Return cached PlotCard if it already exists for today
    if (_todaysPlotCard != null &&
        _todaysPlotCard!.date.year == now.year &&
        _todaysPlotCard!.date.month == now.month &&
        _todaysPlotCard!.date.day == now.day) {
      return _todaysPlotCard;
    }

    // load all recordings from DB
    final recordings = await getRecords();

    // Find the first recording from today (if any)
    final todayRecording = recordings.cast<Recording?>().firstWhere(
      (r) => r != null && r.createdAt.year == now.year && r.createdAt.month == now.month && r.createdAt.day == now.day,
      orElse: () => null,
    );

    if (todayRecording != null) {
      // If found, create a PlotCard based on the mood of this recording
      if (todayRecording.mood != null) {
        await createTodaysPlotCard(todayRecording.mood!);
      }
      return _todaysPlotCard;
    }
    // No PlotCard for today found
    return null;
  }

  Future<void> updateRecord(Recording record) async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Updating record: ${record.toJson()}');
    }

    await _db!.update(_tableName, record.toJson(), where: 'id = ?', whereArgs: [record.id]);
  }

  Future<Recording?> getRecord(int id) async {
    await _ensureInitialized();

    if (kDebugMode) {
      print('Fetching record with id: $id');
    }

    final List<Map<String, dynamic>> maps = await _db!.query(_tableName, where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return mapToRecord(maps.first);
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
