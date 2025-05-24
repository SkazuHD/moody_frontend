import 'package:flutter/material.dart';
import 'package:moody_frontend/views/dashboard/dashboard.dart';
import 'package:moody_frontend/views/welcome/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showWelcome = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFirstVisit();
  }

  Future<void> _checkFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();

    final bool isFirstVisit = prefs.getBool('firstVisit') ?? true;

    if (isFirstVisit) {
      await prefs.setBool('firstVisit', false);
      setState(() {
        _showWelcome = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        _showWelcome = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: Color(0xFF528a7d),
        ),
      );
    }

    return MaterialApp(
      title: 'Soullog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Color(0xFF528a7d),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
      //Replace with route to Home when done
      home: _showWelcome ? const Welcome() : const Dashboard(),
    );
  }
}
