import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/constants/emotions.dart';
import '../../data/db.dart';

class MoodSpotsNotifier {
  final ValueNotifier<List<FlSpot>> spots = ValueNotifier<List<FlSpot>>([]);      // Liste der Punkte
  final ValueNotifier<DateTimeRange> currentRange = ValueNotifier<DateTimeRange>( // Zeitraum: letzte 7 Tage inkl. heute
    DateTimeRange(
      start: DateTime.now()
          .subtract(Duration(days: 6))
          .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0),
      end: DateTime.now()
          .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999),
    ),
  );

  Future<void> fetchAndCalculateSpots() async {   // Einträge aus der Datenbank holen
    RecordsDB db = await RecordsDB.getInstance();    // Instanz der Datenbank

    // Records der letzten 7 Tage laden
    final records = await db.getRecordsByDateRange(
      currentRange.value.start,
      currentRange.value.end,
    );

    // Einen FlSpot pro Aufnahme erstellen (X = Tag, Y = Emotion-Wert)
    final calculatedSpots = records.map((record) {    //Transformation geladenen records --> FlSpot-Objekte
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

    spots.value = calculatedSpots;    //ValueNotifier mit den berechneten Punkten aktualisieren
  }
}