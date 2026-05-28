import 'dart:math';
import 'package:flutter/material.dart';

class BlinkitLogo extends StatelessWidget {
  const BlinkitLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.35,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Wallet Shadow
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),

          /// Wallet Body
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE5C000),
                  Color(0xFFB89D00),
                ],
              ),
            ),
          ),

          /// Top Fold
          // Positioned(
          //   top: 8,
          //   left: 10,
          //   child: Transform.rotate(
          //     angle: 0.15,
          //     child: Container(
          //       width: 92,
          //       height: 36,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(18),
          //         gradient: const LinearGradient(
          //           colors: [
          //             Color(0xFF2E6D00),
          //             Color(0xFF133D00),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          /// Rupee Icon
          const Positioned(
            child: Icon(
              Icons.currency_rupee,
              color: Colors.white,
              size: 58,
              weight: 900,
            ),
          ),
        ],
      ),
    );
  }
}