import 'dart:developer';

import 'package:Soullog/helper/theme_constants.dart';
import 'package:Soullog/views/dashboard/dashboard.dart';
import 'package:Soullog/views/home/home.dart';
import 'package:Soullog/views/record/record.dart';
import 'package:Soullog/views/recordList/recordList.dart';
import 'package:Soullog/views/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _showWelcome = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkFirstVisit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('App lifecycle state changed: $state');
  }

  Future<void> _checkFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstVisit = prefs.getBool('firstVisit') ?? true;

    setState(() {
      _showWelcome = isFirstVisit;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
        theme: AppTheme.defaultTheme,
      );
    }

    return MaterialApp(
      title: 'Soullog',
      theme: AppTheme.defaultTheme,
      //Replace with route to Home when done
      home: _showWelcome ? const Welcome() : Home(),
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/entries': (context) => const RecordList(),
        '/record': (context) => const Record(),
        '/home': (context) => const Home(),
        '/welcome': (context) => const Welcome(),
      },
    );
  }
}
