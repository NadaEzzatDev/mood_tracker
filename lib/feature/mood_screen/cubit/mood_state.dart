

import '../../models/mood.dart';

abstract class MoodState {}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<Mood> moods;
  final Mood? todayMood;

  MoodLoaded({
    required this.moods,
    this.todayMood,
  });
}

class MoodError extends MoodState {
  final String message;

  MoodError(this.message);
}
