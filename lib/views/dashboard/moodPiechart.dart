import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSection {
  final Color color;
  final double value;
  final String title;

  PieChartSection({
    required this.color,
    required this.value,
    required this.title,
  });
}

class MoodPieChart extends StatefulWidget {
  final List<PieChartSection> sectionsData;

  const MoodPieChart({super.key, required this.sectionsData});

  @override
  State<StatefulWidget> createState() => MoodPieChartState();
}

class MoodPieChartState extends State<MoodPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.sectionsData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final section = widget.sectionsData[i];

      return PieChartSectionData(
        color: section.color,
        value: section.value,
        title: section.title,
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, color: Colors.black),
      );
    });
  }
}
