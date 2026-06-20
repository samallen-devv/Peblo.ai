# Peblo AI Story Buddy

## Overview

This project is a Flutter implementation of the Peblo AI Story Buddy challenge. The application presents a child-friendly storytelling experience where an AI Buddy narrates a short story using Text-to-Speech (TTS) and then reveals an interactive quiz based on the story.

The goal was to create a lightweight, engaging, and responsive experience suitable for children using mid-range Android devices.

---

## Framework Choice

I chose Flutter because it enables rapid cross-platform development while maintaining a smooth user experience and a single codebase for Android and iOS.

### Technologies Used

* Flutter
* Riverpod (State Management)
* MVVM Architecture
* GoRouter
* Flutter TTS
* Confetti Animation

---

## State Transition Management

The application uses Riverpod and MVVM architecture to manage application state.

State flow:

Idle → Loading → Speaking → Quiz → Success/Error

### Flow

1. User taps "Read Me A Story".
2. TTS engine is initialized.
3. Story narration begins.
4. The app waits for narration completion.
5. After narration finishes, the quiz is revealed automatically.
6. Wrong answers trigger feedback and allow retry.
7. Correct answers trigger a success state and confetti celebration.

This separation of states keeps UI logic predictable and maintainable.

---

## Data-Driven Quiz Implementation

The quiz is rendered from a JSON object rather than hardcoded UI.

Example:

```json
{
  "question": "What colour was Pip the Robot's lost gear?",
  "options": ["Red", "Green", "Blue", "Yellow"],
  "answer": "Blue"
}
```

The UI dynamically generates option buttons from the options array.

Because of this approach:

* Different question text requires no code changes.
* Different option counts (3, 4, 5, or more) are supported automatically.
* The renderer remains reusable for future content delivered from a backend API.

---

## Caching Approach

The current implementation uses the device's native Text-to-Speech engine through flutter_tts, so no audio files are downloaded.

If remote audio were used in production:

* Audio files would be cached locally using a package such as flutter_cache_manager.
* Previously played stories would be loaded from cache.
* This would reduce network requests and improve startup time on slower connections.

---

## Audio Loading & Failure Handling

Before narration starts:

* The app enters a loading state.
* The user receives visual feedback that audio is being prepared.

Error handling:

* Exceptions are caught inside the ViewModel.
* The app transitions into an error state.
* A retry option is presented to the user.
* The application never crashes or hangs when an error occurs.

---

## Performance Profiling

### What Was Measured

* UI responsiveness during animations
* State updates during narration and quiz transitions
* General frame smoothness during interactions

### Optimizations Applied

* Riverpod used to reduce unnecessary rebuilds.
* Widgets split into reusable components.
* Lightweight local assets used.
* Native TTS engine used instead of large external audio files.
* Minimal dependency footprint.

### Result

The application maintains smooth animations and responsive interactions on modest Android devices.

(Frame timing screenshot attached separately.)

---

## Optimization for Mid-Range Android Devices

The challenge specifically targets devices with approximately 3GB RAM.

Optimizations:

* Single-screen architecture
* Lightweight image assets
* Native device TTS
* Minimal memory allocation
* Limited widget rebuilds through Riverpod
* No heavy background processing
* No unnecessary network requests

These decisions help keep memory usage and startup time low.

---

## AI Usage & Judgment

AI tools were used to assist with:

* Architecture planning
* State management structure
* Code review
* Documentation drafting

One suggestion that was intentionally rejected was introducing code generation with Freezed and build_runner.

Reason:
For a small assessment application, the added complexity and build time outweighed the benefits. A simpler manual model implementation improved development speed while maintaining readability.

### Issue Encountered

Initially, the route configuration referenced a screen before it had been created, causing compile-time errors.

Resolution:
The screen was implemented and imports were corrected, restoring successful navigation and application startup.

---

## Project Structure

```text
lib/
│
├── app/
│   ├── app.dart
│   └── router.dart
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_strings.dart
│   │
│   └── services/
│       └── tts_service.dart
│
├── providers/
│   └── providers.dart
│
├── features/
│   └── story_buddy/
│
│       ├── data/
│       │
│       │   ├── models/
│       │   │   └── quiz_model.dart
│       │
│       │   └── repositories/
│       │       └── story_repository.dart
│       │
│       ├── presentation/
│       │
│       │   ├── screens/
│       │   │   └── story_screen.dart
│       │
│       │   └── widgets/
│       │       ├── buddy_avatar.dart
│       │       ├── celebration_overlay.dart
│       │       ├── loading_view.dart
│       │       ├── option_button.dart
│       │       ├── quiz_card.dart
│       │       └── story_card.dart
│       │
│       └── viewmodels/
│           └── story_viewmodel.dart
│
└── main.dart


assets/
│
└── images/
    └── robot_buddy.png
```

### Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern.

**Model**
* quiz_model.dart

**View**

* story_screen.dart
* buddy_avatar.dart
* quiz_card.dart
* option_button.dart
* story_card.dart
* loading_view.dart
* celebration_overlay.dart

**ViewModel**
* story_viewmodel.dart

**Repository**
* story_repository.dart

**Service Layer**
* tts_service.dart

**State Management**
* Riverpod

**Navigation**
* GoRouter

```
```

## Features

* AI Story Buddy Character
* Text-to-Speech Story Narration
* Data-Driven Quiz Engine
* Interactive Answer Selection
* Wrong Answer Feedback
* Success Celebration with Confetti
* Riverpod State Management
* MVVM Architecture
* Child-Friendly UI

---
