# Mood Tracker

A Flutter app to track your daily mood with a game-style UI.

## Features

- **Track Daily Mood**: Select your mood for today (Happy, Neutral, Sad)
- **Custom Drawn Faces**: Mood expressions drawn with Flutter's CustomPainter
- **Mood History**: Horizontal scrollable timeline of past moods
- **Auto-Scroll Animation**: Smoothly scrolls to the newest entry when selecting a mood
- **Persistent Storage**: Moods saved locally using Hive
- **Game-Style UI**: Dark theme with vibrant gradient colors

## Screenshots

| Mood Selection | History Timeline |
|----------------|------------------|
| Custom drawn mood faces | Date and day labels |
| Gradient buttons | Color-coded entries |
| Press animation | Smooth scroll |

## Tech Stack

- **Flutter** - UI framework
- **Cubit (flutter_bloc)** - State management
- **Hive** - Local NoSQL storage
- **CustomPainter** - Hand-drawn mood faces

## Project Structure

```
lib/
├── main.dart
├── core/
│   └── theme/
│       └── app_theme.dart          # Colors, gradients, typography
├── feature/
│   ├── models/
│   │   └── mood.dart               # Mood model & MoodType enum
│   ├── services/
│   │   └── mood_storage.dart       # Hive storage service
│   └── mood_screen/
│       ├── mood_screen.dart        # Main screen
│       ├── cubit/
│       │   ├── mood_cubit.dart     # State management
│       │   └── mood_state.dart     # State classes
│       └── widgets/
│           ├── mood_face.dart      # CustomPainter faces
│           ├── mood_selector.dart  # Mood selection buttons
│           └── history/
│               └── mood_history_list.dart  # Timeline widget
```

## Getting Started

### Prerequisites

- Flutter SDK ^3.11.0
- Dart SDK

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Generate Hive adapters:
   ```bash
   flutter pub run build_runner build
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Mood Types

| Mood | Color | Face |
|------|-------|------|
| Happy | Yellow/Orange | Curved smile, happy eyes, rosy cheeks |
| Neutral | Gray | Straight mouth, round eyes |
| Sad | Blue | Frown, sad eyebrows, tear drop |
