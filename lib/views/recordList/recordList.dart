import 'package:flutter/material.dart';
import 'package:moody_frontend/components/filterList.dart';

class RecordList extends StatelessWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppBarMoody()),
      body: Center(child: Column(children: [Expanded(child: FilterList())])),
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
