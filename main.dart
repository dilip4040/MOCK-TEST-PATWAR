import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patwari Mock Test',
      home: MockTestPage(),
    );
  }
}

class MockTestPage extends StatefulWidget {
  @override
  _MockTestPageState createState() => _MockTestPageState();
}

class _MockTestPageState extends State<MockTestPage> {
  List questions = [];
  int currentIndex = 0;
  int? selectedOption;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    String data = await rootBundle.loadString('assets/mock_test_1.json');
    setState(() {
      questions = json.decode(data);
    });
  }

  void submitAnswer() {
    setState(() {
      isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    var q = questions[currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text('Mock Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Q${currentIndex + 1}. ${q['question']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            for (int i = 0; i < q['options'].length; i++)
              ListTile(
                title: Text(q['options'][i]),
                leading: Radio(
                  value: i,
                  groupValue: selectedOption,
                  onChanged: isSubmitted ? null : (val) {
                    setState(() {
                      selectedOption = val as int;
                    });
                  },
                ),
              ),
            SizedBox(height: 20),
            if (!isSubmitted)
              ElevatedButton(
                onPressed: selectedOption == null ? null : submitAnswer,
                child: Text('Submit'),
              ),
            if (isSubmitted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedOption == q['answer_index']
                        ? '✅ सही उत्तर!'
                        : '❌ गलत उत्तर',
                    style: TextStyle(fontSize: 18, color: selectedOption == q['answer_index'] ? Colors.green : Colors.red),
                  ),
                  SizedBox(height: 10),
                  Text("विस्तार: ${q['explanation']}"),
                ],
              )
          ],
        ),
      ),
    );
  }
}
