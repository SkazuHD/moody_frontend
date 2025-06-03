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
  return records.map((record) {
    return FlSpot(
      record.createdAt.day.toDouble(),
      record.mood != null
          ? Emotion.values.firstWhere((e) => e.label.toLowerCase() == record.mood!.toLowerCase()).value
          : 0.0,
    );
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
