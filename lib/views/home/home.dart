import 'package:Soullog/views/home/fastCheckin.dart';
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

final moodSpotsNotifier = MoodSpotsNotifier();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    moodSpotsNotifier.loadSpots(pastDays: 7);
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
              decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10)),
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
              onDataChanged: () {
                moodSpotsNotifier.loadSpots(pastDays: 7);
              },
            ),

            // 3. Container Chart
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Mood of the past 7 days:', style: h1Black, textAlign: TextAlign.center),
                  ValueListenableBuilder<List<FlSpot>>(
                    valueListenable: moodSpotsNotifier.spots,
                    builder: (context, spots, _) {
                      if (spots.isEmpty) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(width: double.infinity, child: MoodLineChart(spots: spots));
                    },
                  ),
                ],
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
                    child: Text('Review past thoughts?', style: h1White, softWrap: true), // Text kann umbrechen
                  ),
                  SizedBox(width: 15), // Abstand zwischen Text und Button
                  Expanded(
                    flex: 1, // 50% der Breite
                    child: ElevatedButton(
                      style: greyButtonStyle,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Record()));
                      },
                      child: const Text('To your entries'),
                    ),
                  ),
                ],
              ),
            ),

            // 5. Container - Plot Card
            FutureBuilder<PlotCard?>(
              future: RecordsDB.getInstance().then(
                (db) => db.getTodaysPlotCard(),
              ), // fetch today's PlotCard from the DB
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // loading spinner while waiting for data
                  // Show an error message when error during loading
                } else if (snapshot.hasError) {
                  return Text('Error loading PlotCard. ${snapshot.error}');
                } else {
                  final plotCard = snapshot.data; // Store the fetched data in a local variable when succ

                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFDEBB97), borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Today\'s Plot-Card:', style: h1Black, textAlign: TextAlign.center),
                        const SizedBox(height: 10),
                        if (plotCard != null) ...[
                          Text(plotCard.title, style: h2Black, textAlign: TextAlign.center),
                          const SizedBox(height: 8),
                          Text(plotCard.description, style: bodyBlack, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                        ] else ...[
                          // fallback message if no data is found
                          const Text(
                            'No activities tracked today. Start your day by logging your progress!',
                            style: bodyBlack,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: greyButtonStyle,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Record()));
                            },
                            child: const Text('Record'),
                          ),
                        ],
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
