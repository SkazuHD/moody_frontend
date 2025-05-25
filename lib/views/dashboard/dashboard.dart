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
  int _currentRangeOffset = 7;

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
      _sections.value.clear();
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
  }

  DateTimeRange getDateRange() {
    DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(Duration(days: _currentRangeOffset)),
      end: DateTime.now().subtract(Duration(days: _currentRangeOffset - 7)),
    );

    return dateRange;
  }

  Future<void> _fetchAndUpdateRecords() async {
    RecordsDB db = await RecordsDB.getInstance();
    DateTimeRange currentRange = getDateRange();
    db
        .getRecordsByDateRange(currentRange.start, currentRange.end)
        .then(
          (records) => setState(() {
            if (kDebugMode) {
              log(
                'Fetched ${records.length} records from ${currentRange.start} to ${currentRange.end}',
                name: 'Dashboard',
              );
            }
            _records.value = records;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    DateTimeRange currentRange = getDateRange();
    String formattedDateRange =
        "${DateFormat('dd.MM').format(currentRange.start)} - ${DateFormat('dd.MM.yyyy').format(currentRange.end)}";

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
                            setState(() {
                              _currentRangeOffset += 7;
                            });
                            _fetchAndUpdateRecords(); // Fetch new records
                          },
                        ),
                        Text(
                          formattedDateRange,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            setState(() {
                              if (_currentRangeOffset > 7) {
                                _currentRangeOffset -= 7;
                              }
                            });
                            _fetchAndUpdateRecords(); // Fetch new records
                          },
                        ),
                      ],
                    ),
                    MoodLineChart(spots: _spots.value),
                    Text(
                      "Mood distribution",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    MoodPieChart(sectionsData: _sections.value),
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
