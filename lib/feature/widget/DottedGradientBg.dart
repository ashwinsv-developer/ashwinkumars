import 'package:flutter/cupertino.dart';

class DottedGradientBg extends StatelessWidget {
  const DottedGradientBg();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2A2210), Color(0xFF181814), Color(0xFF0F0F0F)],
          stops: [0.0, 0.3, 1.0],
        ),
      ),
      child: CustomPaint(painter: DotsBgPainter(), size: Size.infinite),
    );
  }
}

class DotsBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 18.0;
    const topFrac  = 0.28;
    for (double y = 0; y < size.height * topFrac; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        final opacity = (1 - y / (size.height * topFrac)) * 0.35;
        canvas.drawCircle(
          Offset(x, y),
          1.5,
          Paint()..color = const Color(0xFF8A7030).withOpacity(opacity),
        );
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
