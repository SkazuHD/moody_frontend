import 'dart:developer';

import 'package:Soullog/data/constants/emotions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoodLineChart extends StatefulWidget {
  final List<FlSpot> spots;

  const MoodLineChart({super.key, required this.spots});

  @override
  State<MoodLineChart> createState() => _MoodLineChartState();
}

class _MoodLineChartState extends State<MoodLineChart> {
  List<Color> get gradientColors {
    return [
      Emotion.angry.color,
      Emotion.fear.color,
      Emotion.sad.color,
      Emotion.happy.color,
      Emotion.calm.color,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.1,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(mainData()),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.black,
    );
    if (value < 0 || value >= widget.spots.length) {
      return Container();
    }

    final text = Text(
      widget.spots.elementAt(value.toInt()).x.toInt().toString(),
      style: style,
    );
    return SideTitleWidget(meta: meta, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    String text;
    Emotion? emotion = Emotion.values.cast<Emotion?>().firstWhere(
      (element) => element!.value.toInt() == value.toInt(),
      orElse: () => null,
    );
    if (emotion == null) {
      return Container();
    }

    text = emotion.emoji;

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    List<FlSpot> plotPoints =
        widget.spots.asMap().entries.map((entry) {
          int index = entry.key; // This is the index of the element
          FlSpot spot = entry.value; // This is the original FlSpot
          return FlSpot(
            index.toDouble(), // Use the index as the x-value
            spot.y,
          );
        }).toList();

    if (kDebugMode) {
      log("Plot Points: $plotPoints");
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Color(0xff37434d), strokeWidth: 0.5);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: -0,
      maxX: plotPoints.length.toDouble() - 1,
      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: plotPoints,
          isCurved: true,
          curveSmoothness: 0.25,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (
              FlSpot spot,
              double percent,
              LineChartBarData barData,
              int index,
            ) {
              return FlDotCirclePainter(
                radius: 4,
                color:
                    gradientColors[(spot.y.toInt() - 1).clamp(
                      0,
                      gradientColors.length - 1,
                    )],
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
