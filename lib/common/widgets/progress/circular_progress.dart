import "dart:math" as math;
import "package:flutter/material.dart" hide Route;

class CircularProgressWithText extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient progressGradient;
  final TextStyle? textStyle;

  const CircularProgressWithText({
    super.key,
    required this.progress,
    required this.size,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressGradient,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress.clamp(0, 1)),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _CircularProgressPainter(
              progress: animatedValue,
              backgroundColor: backgroundColor,
              progressGradient: progressGradient,
              strokeWidth: strokeWidth,
              size: size,
            ),
            child: Center(child: Text("${(animatedValue * 100).round()}%", style: textStyle)),
          ),
        );
      },
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Gradient progressGradient;
  final double strokeWidth;
  final double size;

  _CircularProgressPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressGradient,
    required this.strokeWidth,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) - (strokeWidth / 2);
    const startAngle = -math.pi / 2;

    final bg =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final shader = progressGradient.createShader(rect);

    final fg =
        Paint()
          ..shader = shader
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bg);

    canvas.drawArc(rect, startAngle, -2 * math.pi * progress, false, fg);
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter old) =>
      old.progress != progress ||
      old.backgroundColor != backgroundColor ||
      old.progressGradient != progressGradient ||
      old.strokeWidth != strokeWidth;
}
