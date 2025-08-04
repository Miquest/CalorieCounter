import 'package:flutter/material.dart';
import 'dart:math';

class ProgressCirclePainter extends CustomPainter {
  final double progress;
  final Color baseColor;
  final Color progressColor;
  final double strokeWidth;

  ProgressCirclePainter({
    required this.progress,
    required this.baseColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    final Paint basePaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, basePaint);

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweepAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressCirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class ProgressArc extends StatelessWidget {

  final Icon icon;
  final double progress;
  final double size;
  const ProgressArc({super.key, required this.icon, required this.progress, required this.size});


  @override
  Widget build(BuildContext context) {

    final Color arcColor = Colors.deepPurple;

    return Stack(
      alignment: Alignment.center,
      children: [
        Center(child: icon),

        CustomPaint(
          size: Size(size, size),
          painter: ProgressCirclePainter(
            progress: progress,
            baseColor: arcColor.withAlpha(800),
            progressColor: arcColor,
            strokeWidth: 12 * (size / 130),
          ),
        ),
      ],
    );
  }
}
