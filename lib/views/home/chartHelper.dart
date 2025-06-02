import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/constants/emotions.dart';
import '../../data/db.dart';
import '../../data/models/record.dart';

class MoodSpotsNotifier {
  final ValueNotifier<List<FlSpot>> spots = ValueNotifier([]);

  Future<void> loadSpots({required int pastDays}) async {
    final now = DateTime.now();
    final range = DateTimeRange(
      start: now.subtract(Duration(days: pastDays)),
      end: now,
    );

    final db = await RecordsDB.getInstance();
    final records = await db.getRecordsByDateRange(range.start, range.end);

    spots.value = _calculateSpots(records);
  }

  List<FlSpot> _calculateSpots(List<Recording> records) {
    return records.map((record) {
      return FlSpot(
        record.createdAt.day.toDouble(),
        record.mood != null
            ? Emotion.values
            .firstWhere(
              (e) => e.label.toLowerCase() == record.mood!.toLowerCase(),
        )
            .value
            : 0.0,
      );
    }).toList();
  }
}
