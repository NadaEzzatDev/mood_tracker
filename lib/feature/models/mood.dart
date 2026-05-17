import 'package:hive/hive.dart';

part 'mood.g.dart';

@HiveType(typeId: 0)
enum MoodType {
  @HiveField(0)
  happy,

  @HiveField(1)
  neutral,

  @HiveField(2)
  sad,
}

@HiveType(typeId: 1)
class Mood extends HiveObject {
  @HiveField(0)
  final MoodType type;

  @HiveField(1)
  final DateTime date;

  Mood({
    required this.type,
    required this.date,
  });

  String get label {
    switch (type) {
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.sad:
        return 'Sad';
    }
  }
}
