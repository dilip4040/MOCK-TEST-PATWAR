import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(PatwariApp());
}

class PatwariApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patwari 2025 Mock Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
    );
  }
}