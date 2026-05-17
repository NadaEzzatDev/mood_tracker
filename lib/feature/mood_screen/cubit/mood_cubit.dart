import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/mood.dart';
import '../../services/mood_storage.dart';
import 'mood_state.dart';

class MoodCubit extends Cubit<MoodState> {
  final MoodStorage _storage;

  MoodCubit(this._storage) : super(MoodInitial());

  Future<void> loadMoods() async {
    emit(MoodLoading());
    try {
      final moods = _storage.getAllMoods();
      final todayMood = _storage.getTodayMood();
      emit(MoodLoaded(moods: moods, todayMood: todayMood));
    } catch (e) {
      emit(MoodError(e.toString()));
    }
  }

  Future<void> selectMood(MoodType type) async {
    try {
      await _storage.updateTodayMood(type);
      // await _storage.updateMoodByDate(type ,   DateTime(2026, 5, 18),);
      await loadMoods();
    } catch (e) {
      emit(MoodError(e.toString()));
    }
  }
}
