import 'dart:async';
import 'dart:developer';

import 'package:Soullog/components/loadingIndicator.dart';
import 'package:Soullog/data/constants/emotions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PieChartSection {
  final Color color;
  final double value;
  final String title;
  final Emotion emotion;

  PieChartSection({required this.color, required this.value, required this.title, required this.emotion});
}

class MoodPieChart extends StatefulWidget {
  final List<PieChartSection> sectionsData;
  final bool isLoading;

  const MoodPieChart({super.key, required this.sectionsData, this.isLoading = false});

  @override
  State<StatefulWidget> createState() => MoodPieChartState();
}

class MoodPieChartState extends State<MoodPieChart> {
  int touchedIndex = -1;
  Timer? _resetTouchTimer;

  @override
  void dispose() {
    _resetTouchTimer?.cancel();
    super.dispose();
  }

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
              child:
                  widget.isLoading
                      ? loadingIndicator()
                      : PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                                  return;
                                }
                                if (event is FlTapDownEvent || event is FlLongPressEnd) {
                                  final index = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                  touchedIndex = (touchedIndex == index) ? -1 : index;
                                  if (_resetTouchTimer != null && _resetTouchTimer!.isActive) {
                                    _resetTouchTimer!.cancel();
                                  }
                                  _resetTouchTimer = Timer(const Duration(milliseconds: 3500), () {
                                    if (mounted) {
                                      setState(() {
                                        touchedIndex = -1;
                                      });
                                    }
                                  });
                                }
                              });
                            },
                          ),
                          titleSunbeamLayout: false,
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
    if (kDebugMode) {
      log("Showing ${widget.sectionsData.length} sections");
    }

    return List.generate(widget.sectionsData.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 16.0;
      final radius = isTouched ? 95.0 : 88.0;
      final section = widget.sectionsData[i];

      return PieChartSectionData(
        color: section.color,
        value: section.value,
        title: isTouched ? '' : '${section.emotion.emoji} ${section.title} ',
        badgeWidget:
            isTouched ? Text(section.emotion.label, style: TextStyle(color: Colors.black, fontSize: fontSize)) : null,
        badgePositionPercentageOffset: 0.5,
        titlePositionPercentageOffset: 0.5,
        radius: radius,
        titleStyle: TextStyle(fontSize: fontSize, color: Colors.black),
      );
    });
  }
}
