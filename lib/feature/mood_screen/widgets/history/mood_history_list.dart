import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../models/mood.dart';
import '../mood_face.dart';

class MoodHistoryList extends StatefulWidget {
  final List<Mood> moods;

  const MoodHistoryList({super.key, required this.moods});

  @override
  State<MoodHistoryList> createState() => _MoodHistoryListState();
}

class _MoodHistoryListState extends State<MoodHistoryList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(MoodHistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If a new mood was added or updated, scroll to the last item (newest)
    if (widget.moods.isNotEmpty) {
      _scrollToLast();
    }
  }

  void _scrollToLast() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Color _getMoodColor(MoodType type) {
    switch (type) {
      case MoodType.happy:
        return AppColors.happy;
      case MoodType.sad:
        return AppColors.sad;
      case MoodType.neutral:
        return AppColors.neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.moods.isEmpty) {
      return Container(
        height: 140,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 40,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'No mood history yet',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 140,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.moods.length,
        itemBuilder: (context, index) {
          final mood = widget.moods[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _MoodHistoryItem(
              mood: mood,
              color: _getMoodColor(mood.type),
            ),
          );
        },
      ),
    );
  }
}

class _MoodHistoryItem extends StatelessWidget {
  final Mood mood;
  final Color color;

  const _MoodHistoryItem({required this.mood, required this.color});

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final moodDate = DateTime(date.year, date.month, date.day);

    if (moodDate == today) {
      return 'Today';
    } else if (moodDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${date.day} ${months[date.month - 1]}';
    }
  }

  String _getDayName(DateTime date) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Color accent bar at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Custom drawn mood face
                MoodFace(moodType: mood.type, size: 50),
                const SizedBox(height: 8),
                // Date
                Text(
                  _formatDate(mood.date),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Day name
                Text(
                  _getDayName(mood.date),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
