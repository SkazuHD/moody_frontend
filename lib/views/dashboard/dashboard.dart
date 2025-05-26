import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moody_frontend/data/constants/emotions.dart';
import 'package:moody_frontend/data/db.dart';
import 'package:moody_frontend/views/dashboard/moodPiechart.dart';

import '../../data/models/record.dart';
import 'moodLinechart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _records = ValueNotifier<List<Recording>>([]);
  final _spots = ValueNotifier<List<FlSpot>>([]);
  final _sections = ValueNotifier<List<PieChartSection>>([]);
  final _currentRangeOffset = ValueNotifier<int>(7);
  final _currentRange = ValueNotifier<DateTimeRange>(
    DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now(),
    ),
  );

  @override
  void initState() {
    super.initState();
    _fetchAndUpdateRecords();
    _records.addListener(() {
      _spots.value =
          _records.value.map((record) {
            return FlSpot(
              record.createdAt.day.toDouble(),
              record.mood != null
                  ? Emotion.values
                      .firstWhere(
                        (e) =>
                            e.label.toLowerCase() == record.mood!.toLowerCase(),
                      )
                      .value
                  : 0.0,
            );
          }).toList();
      _spots.value.sort((a, b) => a.x.compareTo(b.x));
      if (kDebugMode) {
        log('Updated spots: ${_spots.value} spots', name: 'Dashboard');
      }
      _sections.value = [];
      for (var emotion in Emotion.values) {
        double total =
            _records.value
                .where(
                  (record) =>
                      record.mood != null &&
                      record.mood!.toLowerCase() == emotion.label.toLowerCase(),
                )
                .length
                .toDouble();
        _sections.value.add(
          PieChartSection(
            color: emotion.color,
            value: total,
            title:
                '${(total / _records.value.length * 100).toStringAsFixed(1)}%',
          ),
        );
      }
    });
    _currentRangeOffset.addListener(() {
      _currentRange.value = DateTimeRange(
        start: DateTime.now().subtract(
          Duration(days: _currentRangeOffset.value),
        ),
        end: DateTime.now().subtract(
          Duration(days: _currentRangeOffset.value - 7),
        ),
      );
      _fetchAndUpdateRecords();
    });
  }

  @override
  void dispose() {
    _records.dispose();
    _spots.dispose();
    _sections.dispose();
    _currentRangeOffset.dispose();
    _currentRange.dispose();
    super.dispose();
  }

  Future<void> _fetchAndUpdateRecords() async {
    RecordsDB db = await RecordsDB.getInstance();
    DateTimeRange currentRange = _currentRange.value;
    _records.value = await db.getRecordsByDateRange(
      currentRange.start,
      currentRange.end,
    );
  }

  String formatDateRange(DateTimeRange range) {
    return "${DateFormat('dd.MM').format(range.start)} - ${DateFormat('dd.MM.yyyy').format(range.end)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFE4E4E4),
                ),
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Mood overview",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            _currentRangeOffset.value += 7;
                          },
                        ),
                        ValueListenableBuilder<DateTimeRange>(
                          valueListenable: _currentRange,
                          builder: (context, range, child) {
                            return Text(
                              formatDateRange(range),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            if (_currentRangeOffset.value > 7) {
                              _currentRangeOffset.value -= 7;
                            }
                          },
                        ),
                      ],
                    ),
                    ValueListenableBuilder<List<FlSpot>>(
                      valueListenable: _spots,
                      builder: (context, spotsValue, child) {
                        return MoodLineChart(spots: spotsValue);
                      },
                    ),
                    Text(
                      "Mood distribution",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ValueListenableBuilder<List<PieChartSection>>(
                      valueListenable: _sections,
                      builder: (context, sectionsValue, child) {
                        return MoodPieChart(sectionsData: sectionsValue);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
