import 'package:Soullog/data/constants/emotions.dart';
import 'package:flutter/material.dart';

import '../../components/filterList.dart';
import '../../components/header.dart';
import '../../data/db.dart';
import '../../data/models/record.dart';
import '../../services/audio-service.dart';

class RecordList extends StatefulWidget {
  const RecordList({super.key});

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  final _records = ValueNotifier<List<Recording>>([]);
  final _audioService = AudioService();

  @override
  void dispose() {
    _records.dispose();
    _audioService.stop();
    super.dispose();
  }

  @override
  // Initialize the state and fetch the records from the database
  void initState() {
    super.initState();
    // Initialize the records with the data from the database
    _fetchRecords();
  }

  Future<void> _fetchRecords() async {
    RecordsDB db = await RecordsDB.getInstance();
    _records.value = await db.getRecords(sort: "DESC");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<List<Recording>>(
                valueListenable: _records,
                builder: (context, recordings, _) {
                  return FilterList(recordings: recordings, categories: Emotion.values.map((e) => e.label).toList());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
