import 'dart:developer';

import 'package:Soullog/components/loadingIndicator.dart';
import 'package:Soullog/data/constants/emotions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'chartHelpers.dart';

class MoodLineChart extends StatefulWidget {
  final List<FlSpot> spots;
  final bool isLoading;
  static const int maxY = 8;

  const MoodLineChart({super.key, required this.spots, this.isLoading = false});

  @override
  State<MoodLineChart> createState() => _MoodLineChartState();
}

class _MoodLineChartState extends State<MoodLineChart> {
  List<Color> _gradientColors = [const Color(0xff23b6e6), const Color(0xff02d39a)];
  List<FlSpot> _plotPoints = [];
  List<FlSpot> _spots = [];

  @override
  void initState() {
    super.initState();
    _updateChartData(widget.spots);
  }

  @override
  void didUpdateWidget(MoodLineChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.spots != oldWidget.spots) {
      _updateChartData(widget.spots);
    }
  }

  void _updateChartData(List<FlSpot> spots) {
    setState(() {
      _gradientColors = calculateGradientColors(spots);
      _plotPoints = calculatePlotPoints(spots);
      _spots = spots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.1,
          child: Padding(
            padding: const EdgeInsets.only(right: 18, left: 12, top: 24, bottom: 12),
            child: widget.isLoading ? loadingIndicator() : LineChart(mainData(_plotPoints, _gradientColors)),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black);
    if (value < 0 || value >= _spots.length) {
      return Container();
    }

    final text = Text(_spots.elementAt(value.toInt()).x.toInt().toString(), style: style);
    return SideTitleWidget(meta: meta, child: text);
  }

  static final Map<int, Widget> _emotionWidgets = _createEmotionWidgetsMap(MoodLineChart.maxY);

  static Map<int, Widget> _createEmotionWidgetsMap(int maxY) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    final Map<int, Widget> map = {};

    for (int i = 1; i <= maxY; i++) {
      Emotion? emotion = Emotion.values.cast<Emotion?>().firstWhere(
        (element) => element!.value.toInt() == i,
        orElse: () => null,
      );

      if (emotion == null) {
        map[i] = Container();
      } else {
        map[i] = Text(emotion.emoji, style: style, textAlign: TextAlign.left);
      }
    }

    return map;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return _emotionWidgets[value.toInt()] ?? Container();
  }

  LineChartData mainData(List<FlSpot> plotPoints, List<Color> gradientColors) {
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
        topTitles: AxisTitles(sideTitles: const SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: const SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 30, interval: 1, getTitlesWidget: bottomTitleWidgets),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, interval: 1, getTitlesWidget: leftTitleWidgets, reservedSize: 42),
        ),
      ),
      borderData: FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d))),
      minX: -0,
      maxX: plotPoints.length.toDouble() - 1,
      minY: 1,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: plotPoints,
          isCurved: false,
          curveSmoothness: 0.25,
          preventCurveOverShooting: true,
          gradient: LinearGradient(colors: gradientColors, begin: Alignment.centerLeft, end: Alignment.centerRight),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (FlSpot spot, double percent, LineChartBarData barData, int index) {
              return FlDotCirclePainter(
                radius: 4,
                color: gradientColors[index % gradientColors.length],
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
