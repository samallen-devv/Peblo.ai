import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/tts_service.dart';
import '../features/story_buddy/data/repositories/story_repository.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepository();
});

final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});
