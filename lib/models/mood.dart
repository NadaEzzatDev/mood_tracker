import 'package:hive/hive.dart';

part 'mood.g.dart';

@HiveType(typeId: 0)
enum MoodType {
  @HiveField(0)
  happy,

  @HiveField(1)
  sad,

  @HiveField(2)
  angry,
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

  String get emoji {
    switch (type) {
      case MoodType.happy:
        return '😊';
      case MoodType.sad:
        return '😢';
      case MoodType.angry:
        return '😠';
    }
  }

  String get label {
    switch (type) {
      case MoodType.happy:
        return 'Happy';
      case MoodType.sad:
        return 'Sad';
      case MoodType.angry:
        return 'Angry';
    }
  }
}
