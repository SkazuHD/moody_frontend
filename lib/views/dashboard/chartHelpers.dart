import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/constants/emotions.dart';
import '../../data/models/record.dart';
import 'moodPiechart.dart';

List<PieChartSection> calculateSections(List<Recording> records) {
  List<PieChartSection> sections = [];
  for (var emotion in Emotion.values) {
    double total =
        records
            .where((record) => record.mood != null && record.mood!.toLowerCase() == emotion.label.toLowerCase())
            .length
            .toDouble();
    sections.add(
      PieChartSection(
        color: emotion.color,
        value: total,
        title: '${(total / records.length * 100).toStringAsFixed(1)}%',
        emotion: emotion,
      ),
    );
  }
  return sections;
}

List<FlSpot> calculatePlotPoints(List<FlSpot> spots) {
  return spots.asMap().entries.map((entry) {
    int index = entry.key;
    FlSpot spot = entry.value;
    return FlSpot(index.toDouble(), spot.y);
  }).toList();
}

List<FlSpot> calculateSpots(List<Recording> records) {
  final Map<String, Recording> latestPerDay = {};
  for (var record in records) {
    final date = record.createdAt;
    final key = '${date.year}-${date.month}-${date.day}';
    if (!latestPerDay.containsKey(key) || record.createdAt.isAfter(latestPerDay[key]!.createdAt)) {
      latestPerDay[key] = record;
    }
  }
  return latestPerDay.values.map((record) {
    final date = record.createdAt;
    final x = date.day.toDouble();
    final y =
        record.mood != null
            ? Emotion.values.firstWhere((e) => e.label.toLowerCase() == record.mood!.toLowerCase()).value
            : 0.0;
    return FlSpot(x, y);
  }).toList();
}

List<Color> calculateGradientColors(List<FlSpot> spots) {
  if (spots.isEmpty || spots.length < 2) {
    return [Colors.grey, Colors.grey];
  }

  return spots.map((spot) {
    return Emotion.values
        .firstWhere((element) => element.value.toInt() == spot.y.toInt(), orElse: () => Emotion.neutral)
        .color;
  }).toList();
}
