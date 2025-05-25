import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moody_frontend/data/constants/emotions.dart';
import 'package:moody_frontend/views/dashboard/moodPiechart.dart';

import 'moodLinechart.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  // Example spots data
  final List<FlSpot> _sampleSpots = const [
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3),
    FlSpot(5, 2),
    FlSpot(6, 1),
    FlSpot(7, 4),
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
