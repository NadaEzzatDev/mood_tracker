import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../models/mood.dart';
import 'mood_face.dart';

class MoodSelector extends StatelessWidget {
  final MoodType? selectedMood;
  final Function(MoodType) onMoodSelected;

  const MoodSelector({
    super.key,
    this.selectedMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'How are you feeling today?',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _MoodButton(
              moodType: MoodType.happy,
              label: 'Happy',
              gradientColors: AppColors.happyGradient,
              isSelected: selectedMood == MoodType.happy,
              onTap: () => onMoodSelected(MoodType.happy),
            ),
            _MoodButton(
              moodType: MoodType.neutral,
              label: 'Neutral',
              gradientColors: AppColors.neutralGradient,
              isSelected: selectedMood == MoodType.neutral,
              onTap: () => onMoodSelected(MoodType.neutral),
            ),
            _MoodButton(
              moodType: MoodType.sad,
              label: 'Sad',
              gradientColors: AppColors.sadGradient,
              isSelected: selectedMood == MoodType.sad,
              onTap: () => onMoodSelected(MoodType.sad),
            ),
          ],
        ),
      ],
    );
  }
}

class _MoodButton extends StatefulWidget {
  final MoodType moodType;
  final String label;
  final List<Color> gradientColors;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodButton({
    required this.moodType,
    required this.label,
    required this.gradientColors,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<_MoodButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 100,
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.gradientColors,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isSelected ? AppColors.textPrimary : Colors.transparent,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors[0].withValues(alpha: 0.6),
                blurRadius: widget.isSelected ? 20 : 12,
                offset: const Offset(0, 6),
                spreadRadius: widget.isSelected ? 2 : 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MoodFace(
                moodType: widget.moodType,
                size: widget.isSelected ? 56 : 48,
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              if (widget.isSelected) ...[
                const SizedBox(height: 4),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.textPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
