import 'package:Soullog/components/plotCardComponent.dart';
import 'package:Soullog/views/dashboard/dashboard.dart';
import 'package:Soullog/views/home/fastCheckin.dart';
import 'package:Soullog/views/recordList/recordList.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../components/greyButton.dart';
import '../../components/header.dart';
import '../../components/headlines.dart';
import '../../data/db.dart';
import '../../data/models/plotCard.dart';
import '../../views/record/record.dart';
import '../dashboard/moodLinechart.dart';
import 'chartHelper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final moodSpotsNotifier = MoodSpotsNotifier();

  @override
  void initState() {
    super.initState();
    moodSpotsNotifier.loadSpots(pastDays: 7);
    // PlotCard aus SharedPreferences laden
    RecordsDB.getInstance().then((db) => db.loadTodaysPlotCard());
  }

  @override
  void dispose() {
    super.dispose();
    moodSpotsNotifier.spots.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            // 1. Container Text-Button
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'A moment from today - would you like to capture it?',
                    style: h1Black,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: greyButtonStyle,
                    onPressed: () {
                      Navigator.of(context).push(
                        //Replace with route to Home when done
                        MaterialPageRoute(builder: (context) => Record()),
                      );
                    },
                    child: const Text('Record'),
                  ),
                ],
              ),
            ),

            // 2. Container Fast check-in
            Fastcheckin(
              onDataChanged: () async {
                await moodSpotsNotifier.loadSpots(pastDays: 7);
              },
            ),

            // 3. Container Chart
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: AbsorbPointer(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Mood of the past 7 days:',
                        style: h1Black,
                        textAlign: TextAlign.center,
                      ),
                      ValueListenableBuilder<List<FlSpot>>(
                        valueListenable: moodSpotsNotifier.spots,
                        builder: (context, spots, _) {
                          if (spots.isEmpty) {
                            return const CircularProgressIndicator();
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: MoodLineChart(spots: spots),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. Container - Text-Button
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    flex: 1, // 50% der Breite
                    child: Text(
                      'Review past thoughts?',
                      style: h1White,
                      softWrap: true,
                    ), // Text kann umbrechen
                  ),
                  SizedBox(width: 15), // Abstand zwischen Text und Button
                  Expanded(
                    flex: 1, // 50% der Breite
                    child: ElevatedButton(
                      style: greyButtonStyle,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RecordList()),
                        );
                      },
                      child: const Text('To your entries'),
                    ),
                  ),
                ],
              ),
            ),

            // 5. Container - Plot Card
            // fetch today's PlotCard from the DB
            FutureBuilder<RecordsDB>(
              future: RecordsDB.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                final db = snapshot.data!;
                return StreamBuilder<PlotCard?>(
                  stream: db.todaysPlotCardStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('No plot card available');
                    }
                    final plotCard = snapshot.data!;
                    return PlotCardComponent(plotCard: plotCard);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
