import 'package:flutter/material.dart';

import '../../components/filterList.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dashboard', style: Theme.of(context).textTheme.bodyLarge),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  //Replace with route to Home when done
                  MaterialPageRoute(builder: (context) => const FilterList()),
                );
              },
              child: Text("RecordList"),
            ),
          ],
        ),
      ),
    );
  }
}
