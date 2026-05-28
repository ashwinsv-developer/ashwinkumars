import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/Constants.dart';

class ConfettiPainter extends CustomPainter {
  final double progress;

  ConfettiPainter(this.progress);

  final List<Color> colors = const [
    AppColors.confettiBlue,
    AppColors.confettiYellow,
    AppColors.confettiGreen,
    AppColors.confettiPink,
    AppColors.confettiRed,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);

    // Rich particle count for a single, high-impact burst
    for (int i = 0; i < 40; i++) {
      // Staggered start times for a more natural "cannon" feel
      final double stagger = random.nextDouble() * 0.2;
      final double localProgress = (progress * 1.2 - stagger).clamp(0.0, 1.0);

      if (localProgress <= 0) continue;

      // Fade out as the particles reach the end of their trajectory
      final double opacity = localProgress > 0.8
          ? (1.0 - localProgress) / 0.2
          : (localProgress < 0.05 ? localProgress / 0.05 : 1.0);

      final paint = Paint()
        ..color = colors[i % colors.length].withOpacity(opacity.clamp(0.0, 1.0))
        ..style = PaintingStyle.fill;

      if (opacity <= 0) continue;

      final isLeft = i % 2 == 0;

      // FAST PHYSICS: High velocity and gravity to maintain that energetic "Blinkit" feel
      // regardless of the overall sequence duration.
      final velocity = 3000.0 + random.nextDouble() * 2000.0;
      final gravity = 9500.0;
      
      final startX = isLeft ? 0.0 : size.width;
      final startY = size.height * 0.65; // Shoot from the sides

      // Angle: Shrapnel-like upward burst
      final baseAngle = isLeft
          ? -(pi * (70.0 + random.nextDouble() * 25.0) / 180.0)
          : -(pi - pi * (70.0 + random.nextDouble() * 25.0) / 180.0);

      final x = startX + cos(baseAngle) * velocity * localProgress;
      final y = startY
          + sin(baseAngle) * velocity * localProgress
          + 0.5 * gravity * (localProgress * localProgress);

      // Skip drawing if way off screen for performance
      if (y > size.height + 60 || x < -60 || x > size.width + 60) continue;

      final rect = Rect.fromCenter(
        center: Offset(x, y),
        width: random.nextDouble() * 5 + 4,
        height: random.nextDouble() * 9 + 6,
      );

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(localProgress * pi * 15 + i); // Continuous tumbling
      canvas.translate(-x, -y);

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(2)),
        paint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConfettiPainter oldDelegate) => true;
}
