import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../cubit/mood_cubit.dart';
import '../../cubit/mood_state.dart';
import 'mood_history_list.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32, left: 16 , bottom: 8),
          child: const Row(
            spacing: 6,
            children: [
              Icon(Icons.history, color: AppColors.textPrimary, size: 18),
              Text(
                'Your History',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // History list
        BlocBuilder<MoodCubit, MoodState>(
          builder: (context, state) {
            if (state is MoodLoaded) {
              return MoodHistoryList(moods: state.moods);
            }
            if (state is MoodError) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              );
            }
            return const SizedBox(
              height: 120,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          },
        ),
      ],
    );
  }
}
