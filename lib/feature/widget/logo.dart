import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/app_constants.dart';

class BlinkitLogo extends StatelessWidget {
  final double size;
  const BlinkitLogo({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppStrings.walletSvg,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
