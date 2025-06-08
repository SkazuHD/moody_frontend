import 'package:Soullog/views/recordList/FastCheckInCard.dart';
import 'package:Soullog/views/recordList/RecordCard.dart';
import 'package:flutter/material.dart';

import '../data/db.dart';
import '../data/models/record.dart';
import 'headlines.dart';

class FilterList extends StatefulWidget {
  final List<Recording> recordings;
  final List<String> categories;

  const FilterList({super.key, required this.recordings, required this.categories});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final List<String> _selectedCategories = [];
  final List<Recording> _selectedRecordings = [];
  bool _isSelectionMode = false;

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
    });
    if (_isSelectionMode == false) {
      _selectedRecordings.clear();
    }
  }

  void deleteSelectedRecordings() {
    if (_selectedRecordings.isEmpty) return _toggleSelectionMode();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Recordings"),
          content: Text("Are you sure you want to delete ${_selectedRecordings.length} recordings?", style: bodyBlack),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final db = await RecordsDB.getInstance();
                await db.deleteRecords(_selectedRecordings);
                setState(() {
                  widget.recordings.removeWhere((recording) => _selectedRecordings.contains(recording));
                });
                _toggleSelectionMode();
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterRecordings =
        widget.recordings.where((recording) {
          return _selectedCategories.isEmpty ||
              _selectedCategories.any((cat) => cat.trim().toLowerCase() == (recording.mood ?? '').trim().toLowerCase());
        }).toList();
    final sortedCategories = List<String>.from(widget.categories)..sort((a, b) {
      final countA =
          widget.recordings.where((r) => (r.mood ?? '').toLowerCase().trim() == a.toLowerCase().trim()).length;
      final countB =
          widget.recordings.where((r) => (r.mood ?? '').toLowerCase().trim() == b.toLowerCase().trim()).length;
      return countB.compareTo(countA);
    });
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFE4E4E4)),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                if (_isSelectionMode)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          _toggleSelectionMode();
                        },
                        icon: Icon(Icons.close),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteSelectedRecordings();
                        },
                        child: Text("Delete (${_selectedRecordings.length})"),
                      ),
                    ],
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        sortedCategories
                            .map(
                              (category) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  selected: _selectedCategories.contains(category),
                                  label: Text(
                                    '$category (${widget.recordings.where((recording) => recording.mood?.toLowerCase().trim() == category.toLowerCase().trim()).length})',
                                  ),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedCategories.add(category);
                                      } else {
                                        _selectedCategories.remove(category);
                                      }
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filterRecordings.length,
              itemBuilder: (context, index) {
                final recording = filterRecordings[index];
                Widget cardWidget =
                    recording.isFastCheckIn ? FastCheckInCard(recording: recording) : RecordCard(recording: recording);

                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      if (!_selectedRecordings.contains(recording)) {
                        _selectedRecordings.add(recording);
                      }
                      _toggleSelectionMode();
                    });
                  },
                  child:
                      _isSelectionMode
                          ? CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: _selectedRecordings.contains(recording),
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  _selectedRecordings.add(recording);
                                } else {
                                  _selectedRecordings.remove(recording);
                                }
                              });
                            },
                            title: cardWidget,
                          )
                          : cardWidget,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
