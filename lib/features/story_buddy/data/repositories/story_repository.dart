import '../models/quiz_model.dart';

class StoryRepository {
  Future<QuizModel> getQuiz() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    final json = {
      "question": "What colour was Pip the Robot's lost gear?",
      "options": [
        "Red",
        "Green",
        "Blue",
        "Yellow",
      ],
      "answer": "Blue",
    };

    return QuizModel.fromJson(json);
  }
}
