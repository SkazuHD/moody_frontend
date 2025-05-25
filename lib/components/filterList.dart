import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  const FilterList({super.key});

  @override
  State<FilterList> createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  final List<String> categories = [
    "Happy",
    "Sad",
    "Angry",
    "Surprised",
    "Neutral",
    "Fearful",
    "Disgusted",
    "Calm",
  ];

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  categories
                      .map(
                        (category) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilterChip(
                            label: Text(category),
                            onSelected: (selected) {},
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8,
                margin: const EdgeInsets.all(8),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.indigoAccent),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    title: Text(
                      "Example name",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Example subtitle",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
