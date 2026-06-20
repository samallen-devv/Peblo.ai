import 'package:flutter/material.dart';

import '../../data/models/quiz_model.dart';
import 'option_button.dart';

class QuizCard extends StatelessWidget {
  final QuizModel quiz;
  final Function(String) onAnswerSelected;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            quiz.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          ...quiz.options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: OptionButton(
                text: option,
                onTap: () {
                  onAnswerSelected(option);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
