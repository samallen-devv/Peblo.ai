import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../viewmodels/story_viewmodels.dart';
import '../widgets/buddy_avatar.dart';
import '../widgets/celebration_overlay.dart';
import '../widgets/loading_view.dart';
import '../widgets/quiz_card.dart';
import '../widgets/story_card.dart';

class StoryScreen extends ConsumerWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(storyViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF7F3FF),
                    Color(0xFFEDE9FE),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  BuddyAvatar(
                    isSuccess: state.status == StoryStatus.success,
                  ),
                  const SizedBox(height: 24),
                  const StoryCard(
                    story: AppStrings.storyText,
                  ),
                  const SizedBox(height: 24),
                  if (state.status == StoryStatus.idle)
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.volume_up),
                        label: const Text(
                          AppStrings.readStory,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          ref
                              .read(
                                storyViewModelProvider.notifier,
                              )
                              .readStory();
                        },
                      ),
                    ),
                  if (state.status == StoryStatus.loading)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: LoadingView(
                        text: AppStrings.loadingStory,
                      ),
                    ),
                  if (state.status == StoryStatus.speaking)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: LoadingView(
                        text: AppStrings.speaking,
                      ),
                    ),
                  if (state.status == StoryStatus.quiz && state.quiz != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        transform: Matrix4.translationValues(
                          state.wrongAnswer ? 8 : 0,
                          0,
                          0,
                        ),
                        child: QuizCard(
                          quiz: state.quiz!,
                          onAnswerSelected: (answer) {
                            ref
                                .read(
                                  storyViewModelProvider.notifier,
                                )
                                .checkAnswer(
                                  answer,
                                );
                          },
                        ),
                      ),
                    ),
                  if (state.status == StoryStatus.success)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '🎉 Amazing Job!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'You helped Pip find his blue gear!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(
                                    storyViewModelProvider.notifier,
                                  )
                                  .retry();
                            },
                            child: const Text(
                              'Play Again',
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (state.status == StoryStatus.error)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: Column(
                        children: [
                          Text(
                            state.errorMessage ?? 'Something went wrong',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(
                                    storyViewModelProvider.notifier,
                                  )
                                  .retry();
                            },
                            child: const Text(
                              'Retry',
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (state.status == StoryStatus.success) const CelebrationOverlay(),
          ],
        ),
      ),
    );
  }
}
