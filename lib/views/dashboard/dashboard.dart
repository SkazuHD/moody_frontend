import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:moody_frontend/data/constants/emotions.dart';
import 'package:moody_frontend/views/dashboard/moodPiechart.dart';

import 'moodLinechart.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

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
                          onPressed: () {},
                        ),
                        Text(
                          "DATERANGE HERE!",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {},
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
