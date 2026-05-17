import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'feature/models/mood.dart';
import 'feature/mood_screen/cubit/mood_cubit.dart';
import 'feature/mood_screen/mood_screen.dart';
import 'feature/services/mood_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(MoodAdapter());
  Hive.registerAdapter(MoodTypeAdapter());

  // Initialize storage
  final moodStorage = MoodStorage();
  await moodStorage.init();

  runApp(MoodTrackerApp(storage: moodStorage));
}

class MoodTrackerApp extends StatelessWidget {
  final MoodStorage storage;

  const MoodTrackerApp({super.key, required this.storage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoodCubit(storage),
      child: MaterialApp(
        title: 'Mood Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MoodScreen(),
      ),
    );
  }
}
