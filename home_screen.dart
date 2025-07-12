import 'package:flutter/material.dart';
import 'test_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> testNames = List.generate(10, (index) => "Mock Test \${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patwari 2025 – Mock Tests')),
      body: ListView.builder(
        itemCount: testNames.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(testNames[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => TestScreen(testIndex: index),
              ));
            },
          );
        },
      ),
    );
  }
}