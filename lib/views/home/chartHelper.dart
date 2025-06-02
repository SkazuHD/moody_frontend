import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/db.dart';
import '../dashboard/chartHelpers.dart';

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

    spots.value = await calculateSpots(records);
  }
}
