import 'package:flutter/material.dart';
import '../../models/mood.dart';
import '../../../core/theme/app_theme.dart';

class MoodFace extends StatelessWidget {
  final MoodType moodType;
  final double size;
  final Color? overrideColor;

  const MoodFace({
    super.key,
    required this.moodType,
    this.size = 60,
    this.overrideColor,
  });

  Color get _faceColor {
    if (overrideColor != null) return overrideColor!;
    switch (moodType) {
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
    return CustomPaint(
      size: Size(size, size),
      painter: _MoodFacePainter(
        moodType: moodType,
        faceColor: _faceColor,
      ),
    );
  }
}

class _MoodFacePainter extends CustomPainter {
  final MoodType moodType;
  final Color faceColor;

  _MoodFacePainter({
    required this.moodType,
    required this.faceColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Face background circle
    final facePaint = Paint()
      ..color = faceColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.95, facePaint);

    // Face outline
    final outlinePaint = Paint()
      ..color = faceColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.08;

    canvas.drawCircle(center, radius * 0.95, outlinePaint);

    // Features paint
    final featurePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.08
      ..strokeCap = StrokeCap.round;

    switch (moodType) {
      case MoodType.happy:
        _drawHappyFace(canvas, size, center, radius, featurePaint, strokePaint);
        break;
      case MoodType.sad:
        _drawSadFace(canvas, size, center, radius, featurePaint, strokePaint);
        break;
      case MoodType.neutral:
        _drawNeutralFace(canvas, size, center, radius, featurePaint, strokePaint);
        break;
    }
  }

  void _drawHappyFace(Canvas canvas, Size size, Offset center, double radius,
      Paint featurePaint, Paint strokePaint) {
    // Eyes - happy curved eyes (like ^_^)
    final eyeY = center.dy - radius * 0.15;
    final leftEyeX = center.dx - radius * 0.35;
    final rightEyeX = center.dx + radius * 0.35;

    // Left eye arc
    final leftEyePath = Path();
    leftEyePath.moveTo(leftEyeX - radius * 0.15, eyeY + radius * 0.05);
    leftEyePath.quadraticBezierTo(
      leftEyeX, eyeY - radius * 0.15,
      leftEyeX + radius * 0.15, eyeY + radius * 0.05,
    );
    canvas.drawPath(leftEyePath, strokePaint);

    // Right eye arc
    final rightEyePath = Path();
    rightEyePath.moveTo(rightEyeX - radius * 0.15, eyeY + radius * 0.05);
    rightEyePath.quadraticBezierTo(
      rightEyeX, eyeY - radius * 0.15,
      rightEyeX + radius * 0.15, eyeY + radius * 0.05,
    );
    canvas.drawPath(rightEyePath, strokePaint);

    // Big smile
    final smilePath = Path();
    final smileY = center.dy + radius * 0.15;
    smilePath.moveTo(center.dx - radius * 0.45, smileY);
    smilePath.quadraticBezierTo(
      center.dx, center.dy + radius * 0.65,
      center.dx + radius * 0.45, smileY,
    );
    canvas.drawPath(smilePath, strokePaint);

    // Rosy cheeks
    final cheekPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(leftEyeX - radius * 0.05, eyeY + radius * 0.35),
      radius * 0.12,
      cheekPaint,
    );
    canvas.drawCircle(
      Offset(rightEyeX + radius * 0.05, eyeY + radius * 0.35),
      radius * 0.12,
      cheekPaint,
    );
  }

  void _drawSadFace(Canvas canvas, Size size, Offset center, double radius,
      Paint featurePaint, Paint strokePaint) {
    // Eyes - droopy sad eyes
    final eyeY = center.dy - radius * 0.1;
    final leftEyeX = center.dx - radius * 0.3;
    final rightEyeX = center.dx + radius * 0.3;

    // Sad eyebrows (angled down toward center)
    final browPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.06
      ..strokeCap = StrokeCap.round;

    // Left eyebrow
    canvas.drawLine(
      Offset(leftEyeX - radius * 0.15, eyeY - radius * 0.25),
      Offset(leftEyeX + radius * 0.1, eyeY - radius * 0.15),
      browPaint,
    );
    // Right eyebrow
    canvas.drawLine(
      Offset(rightEyeX - radius * 0.1, eyeY - radius * 0.15),
      Offset(rightEyeX + radius * 0.15, eyeY - radius * 0.25),
      browPaint,
    );

    // Eyes (oval/teardrop shape)
    canvas.drawCircle(Offset(leftEyeX, eyeY), radius * 0.1, featurePaint);
    canvas.drawCircle(Offset(rightEyeX, eyeY), radius * 0.1, featurePaint);

    // Tear drop on left eye
    final tearPath = Path();
    tearPath.moveTo(leftEyeX, eyeY + radius * 0.1);
    tearPath.quadraticBezierTo(
      leftEyeX - radius * 0.08, eyeY + radius * 0.3,
      leftEyeX, eyeY + radius * 0.4,
    );
    tearPath.quadraticBezierTo(
      leftEyeX + radius * 0.08, eyeY + radius * 0.3,
      leftEyeX, eyeY + radius * 0.1,
    );
    final tearPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    canvas.drawPath(tearPath, tearPaint);

    // Sad frown (upside down smile)
    final frownPath = Path();
    final frownY = center.dy + radius * 0.45;
    frownPath.moveTo(center.dx - radius * 0.3, frownY);
    frownPath.quadraticBezierTo(
      center.dx, center.dy + radius * 0.2,
      center.dx + radius * 0.3, frownY,
    );
    canvas.drawPath(frownPath, strokePaint);
  }

  void _drawNeutralFace(Canvas canvas, Size size, Offset center, double radius,
      Paint featurePaint, Paint strokePaint) {
    // Eyes - simple round eyes
    final eyeY = center.dy - radius * 0.1;
    final leftEyeX = center.dx - radius * 0.3;
    final rightEyeX = center.dx + radius * 0.3;

    // Round eyes
    canvas.drawCircle(Offset(leftEyeX, eyeY), radius * 0.12, featurePaint);
    canvas.drawCircle(Offset(rightEyeX, eyeY), radius * 0.12, featurePaint);

    // Straight line mouth
    final mouthY = center.dy + radius * 0.35;
    canvas.drawLine(
      Offset(center.dx - radius * 0.25, mouthY),
      Offset(center.dx + radius * 0.25, mouthY),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MoodFacePainter oldDelegate) {
    return oldDelegate.moodType != moodType || oldDelegate.faceColor != faceColor;
  }
}
