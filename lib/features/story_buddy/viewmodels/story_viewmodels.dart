import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/tts_service.dart';
import '../../../providers/providers.dart';
import '../data/models/quiz_model.dart';

enum StoryStatus {
  idle,
  loading,
  speaking,
  quiz,
  success,
  error,
}

class StoryState {
  final StoryStatus status;
  final QuizModel? quiz;
  final String? errorMessage;
  final bool wrongAnswer;

  const StoryState({
    required this.status,
    this.quiz,
    this.errorMessage,
    this.wrongAnswer = false,
  });

  StoryState copyWith({
    StoryStatus? status,
    QuizModel? quiz,
    String? errorMessage,
    bool? wrongAnswer,
  }) {
    return StoryState(
      status: status ?? this.status,
      quiz: quiz ?? this.quiz,
      errorMessage: errorMessage,
      wrongAnswer: wrongAnswer ?? this.wrongAnswer,
    );
  }
}

class StoryViewModel extends StateNotifier<StoryState> {
  StoryViewModel(
    this._ttsService,
    this._repository,
  ) : super(
          const StoryState(
            status: StoryStatus.idle,
          ),
        );

  final TtsService _ttsService;
  final dynamic _repository;

  static const String storyText =
      "Once upon a time, a clever little robot named Pip lost his shiny blue gear in the Whispering Woods. Pip searched near glowing flowers and sparkling trees but could not find it. With courage and curiosity, Pip continued exploring until he discovered clues that led him to his missing blue gear.";

  Future<void> readStory() async {
    try {
      state = state.copyWith(
        status: StoryStatus.loading,
      );

      await _ttsService.initialize();

      final quiz = await _repository.getQuiz();

      state = state.copyWith(
        status: StoryStatus.speaking,
        quiz: quiz,
      );

      await _ttsService.speak(storyText);

      state = state.copyWith(
        status: StoryStatus.quiz,
      );
    } catch (e) {
      state = state.copyWith(
        status: StoryStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == state.quiz?.answer) {
      HapticFeedback.heavyImpact();

      state = state.copyWith(
        status: StoryStatus.success,
        wrongAnswer: false,
      );
    } else {
      HapticFeedback.mediumImpact();

      state = state.copyWith(
        wrongAnswer: true,
      );

      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          if (mounted) {
            state = state.copyWith(
              wrongAnswer: false,
            );
          }
        },
      );
    }
  }

  void retry() {
    state = const StoryState(
      status: StoryStatus.idle,
    );
  }
}

final storyViewModelProvider =
    StateNotifierProvider<StoryViewModel, StoryState>(
  (ref) {
    return StoryViewModel(
      ref.read(ttsServiceProvider),
      ref.read(storyRepositoryProvider),
    );
  },
);