import 'package:flutter/material.dart';
import '../models/question_model.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int?> userAnswers;

  ResultScreen({required this.questions, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctOption) correct++;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          bool isCorrect = userAnswers[index] == questions[index].correctOption;
          return ListTile(
            title: Text(questions[index].questionText),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your Answer: \${questions[index].options[userAnswers[index] ?? 0]}"),
                Text("Correct Answer: \${questions[index].options[questions[index].correctOption]}"),
                Text("Explanation: \${questions[index].explanation}"),
              ],
            ),
            tileColor: isCorrect ? Colors.green[50] : Colors.red[50],
          );
        },
      ),
    );
  }
}