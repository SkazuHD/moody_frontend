import 'package:fl_chart/fl_chart.dart';
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
  RecordsDB db = RecordsDB();

  List<Recording> records = List.empty();

  int dateSubtract = 7;

  DateTimeRange getDaterange() {
    DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(Duration(days: dateSubtract)),
      end: DateTime.now().subtract(Duration(days: dateSubtract - 7)),
    );

    return dateRange;
  }

  @override
  void initState() {
    super.initState();
    db.init();
    db.getRecords().then(
      (records) => setState(() {
        this.records = records;
        print(this.records);
      }),
    );
  }

  // Example spots data
  final List<FlSpot> _sampleSpots = [
    FlSpot(8, Emotion.fear.value),
    FlSpot(13, Emotion.angry.value),
    FlSpot(15, Emotion.happy.value),
    FlSpot(20, Emotion.fear.value),
    FlSpot(22, Emotion.sad.value),
    FlSpot(23, Emotion.calm.value),
    FlSpot(25, Emotion.angry.value),
  ];

  final List<PieChartSection> _sampleSections = [
    PieChartSection(color: Emotion.happy.color, value: 30, title: '30%'),
    PieChartSection(color: Emotion.sad.color, value: 20, title: '20%'),
    PieChartSection(color: Emotion.calm.color, value: 25, title: '25%'),
    PieChartSection(color: Emotion.fear.color, value: 15, title: '15%'),
    PieChartSection(color: Emotion.angry.color, value: 10, title: '10%'),
  ];

  @override
  Widget build(BuildContext context) {
    DateTimeRange currentRange = getDaterange();
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
                              dateSubtract += 7;
                            });
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
                              if (dateSubtract > 7) {
                                // Prevent going into the future
                                dateSubtract -= 7;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    MoodLineChart(spots: _sampleSpots),
                    Text(
                      "Mood distribution",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    MoodPieChart(sectionsData: _sampleSections),
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
