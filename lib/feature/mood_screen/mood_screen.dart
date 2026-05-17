import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mode_tracker/feature/mood_screen/widgets/history/history_section.dart';
import 'package:mode_tracker/feature/mood_screen/widgets/mood_selector.dart';

import '../../core/theme/app_theme.dart';
import 'cubit/mood_cubit.dart';
import 'cubit/mood_state.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MoodCubit>().loadMoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(22),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.surface],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Title
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  'MOOD TRACKER',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Track your daily vibes',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),

              // Mood selector
              BlocBuilder<MoodCubit, MoodState>(
                builder: (context, state) {
                  final todayMood = state is MoodLoaded
                      ? state.todayMood?.type
                      : null;
                  return MoodSelector(
                    selectedMood: todayMood,
                    onMoodSelected: (type) {
                      context.read<MoodCubit>().selectMood(type);
                    },
                  );
                },
              ),
              // History section
              HistorySection(),
            ],
          ),
        ),
      ),
    );
  }
}
