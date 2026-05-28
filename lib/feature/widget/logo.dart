import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlinkitLogo extends StatelessWidget {
  final double size;
  const BlinkitLogo({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/wallet.svg',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
