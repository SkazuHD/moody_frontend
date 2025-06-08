import 'package:Soullog/components/header.dart';
import 'package:Soullog/components/headlines.dart';
import 'package:Soullog/data/db.dart';
import 'package:Soullog/views/dashboard/moodPiechart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/record.dart';
import '../../helper/chartHelpers.dart';
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
  final _offsetIncrement = ValueNotifier<int>(7);
  final _currentRangeOffset = ValueNotifier<int>(7);
  final _currentRange = ValueNotifier<DateTimeRange>(
    DateTimeRange(start: DateTime.now().subtract(const Duration(days: 7)), end: DateTime.now()),
  );

  final _filterOptions = [7, 14, 30];

  DateTimeRange _calculateDateRange() {
    return DateTimeRange(
      start: DateTime.now().subtract(Duration(days: _currentRangeOffset.value)),
      end: DateTime.now().subtract(Duration(days: _currentRangeOffset.value - _offsetIncrement.value)),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchAndUpdateRecords();

    _records.addListener(() async {
      _spots.value = calculateSpots(_records.value);
      _sections.value = calculateSections(_records.value);
    });
    _currentRangeOffset.addListener(() async {
      _currentRange.value = _calculateDateRange();
      await _fetchAndUpdateRecords();
    });
  }

  @override
  void dispose() {
    _records.dispose();
    _spots.dispose();
    _sections.dispose();
    _currentRangeOffset.dispose();
    _currentRange.dispose();
    _offsetIncrement.dispose();
    super.dispose();
  }

  Future<void> _fetchAndUpdateRecords() async {
    RecordsDB db = await RecordsDB.getInstance();
    DateTimeRange currentRange = _currentRange.value;
    var records = await db.getRecordsByDateRange(currentRange.start, currentRange.end);
    _records.value = records;
  }

  String _formatDateRange(DateTimeRange range) {
    return "${DateFormat('dd.MM').format(range.start)} - ${DateFormat('dd.MM.yyyy').format(range.end)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Color(0xFFE4E4E4)),
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Mood overview", style: h1Black),
                    ValueListenableBuilder(
                      valueListenable: _offsetIncrement,
                      builder: (context, offsetIncrement, child) {
                        return Container(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                _filterOptions.map((filter) {
                                  return FilterChip(
                                    label: Text("$filter days"),
                                    onSelected: (bool selected) {
                                      if (offsetIncrement == filter) return;
                                      _offsetIncrement.value = filter;
                                      _currentRangeOffset.value = filter;
                                    },
                                    selected: filter == offsetIncrement,
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            _currentRangeOffset.value += _offsetIncrement.value;
                          },
                        ),
                        ValueListenableBuilder<DateTimeRange>(
                          valueListenable: _currentRange,
                          builder: (context, range, child) {
                            return Text(_formatDateRange(range), style: h2Black);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            if (_currentRangeOffset.value > _offsetIncrement.value) {
                              _currentRangeOffset.value -= _offsetIncrement.value;
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
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        spacing: 32,
                        children: [
                          const Text("Mood distribution", style: h1Black),
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
            ],
          ),
        ),
      ),
    );
  }
}
