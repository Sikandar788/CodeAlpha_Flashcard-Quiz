import 'package:flutter/material.dart';

class FlashcardWidget extends StatelessWidget {
  final String question;
  final String answer;
  final bool showAnswer;
  final VoidCallback onToggle;
  

  const FlashcardWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.showAnswer,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              showAnswer ? answer : question,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onToggle,
              child: Text(showAnswer ? 'Show Question' : 'Show Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
