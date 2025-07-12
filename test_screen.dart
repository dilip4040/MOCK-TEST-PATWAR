import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/question_model.dart';
import 'result_screen.dart';

class TestScreen extends StatefulWidget {
  final int testIndex;
  TestScreen({required this.testIndex});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentQ = 0;
  List<int?> userAnswers = List.filled(2, null);

  @override
  Widget build(BuildContext context) {
    List<Question> test = mockTest1;

    return Scaffold(
      appBar: AppBar(title: Text('Question \${currentQ + 1}/\${test.length}')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(test[currentQ].questionText, style: TextStyle(fontSize: 18)),
          ),
          ...List.generate(test[currentQ].options.length, (i) {
            return RadioListTile(
              value: i,
              groupValue: userAnswers[currentQ],
              onChanged: (val) {
                setState(() {
                  userAnswers[currentQ] = val as int;
                });
              },
              title: Text(test[currentQ].options[i]),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentQ > 0)
                ElevatedButton(
                  onPressed: () => setState(() => currentQ--),
                  child: Text('Previous'),
                ),
              if (currentQ < test.length - 1)
                ElevatedButton(
                  onPressed: () => setState(() => currentQ++),
                  child: Text('Next'),
                ),
              if (currentQ == test.length - 1)
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => ResultScreen(questions: test, userAnswers: userAnswers)),
                    );
                  },
                  child: Text('Submit'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}