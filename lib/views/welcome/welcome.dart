import 'package:flutter/material.dart';

import '../home/home.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/Soullog.png')),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    //Replace with route to Home when done
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
