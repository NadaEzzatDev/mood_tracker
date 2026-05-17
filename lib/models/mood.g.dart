// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodAdapter extends TypeAdapter<Mood> {
  @override
  final int typeId = 1;

  @override
  Mood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mood(
      type: fields[0] as MoodType,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Mood obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoodTypeAdapter extends TypeAdapter<MoodType> {
  @override
  final int typeId = 0;

  @override
  MoodType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MoodType.happy;
      case 1:
        return MoodType.sad;
      case 2:
        return MoodType.angry;
      default:
        return MoodType.happy;
    }
  }

  @override
  void write(BinaryWriter writer, MoodType obj) {
    switch (obj) {
      case MoodType.happy:
        writer.writeByte(0);
        break;
      case MoodType.sad:
        writer.writeByte(1);
        break;
      case MoodType.angry:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
