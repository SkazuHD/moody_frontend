import 'package:flutter/material.dart';
import 'package:moody_frontend/components/filterList.dart';
import 'package:moody_frontend/data/db.dart';

import '../../components/header.dart';
import '../../data/models/record.dart';

class RecordList extends StatefulWidget {
  const RecordList({super.key});

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  final db = RecordsDB();

  Future<List<Recording>> getRecords() async {
    return db.getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FilterList(
                recordings: recordings,
                categories: [
                  "Happy",
                  "Sad",
                  "Angry",
                  "Surprised",
                  "Neutral",
                  "Fearful",
                  "Disgusted",
                  "Calm",
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarMoody extends StatelessWidget {
  const AppBarMoody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text("Image"), Text("SoulLog")],
    );
  }
}
