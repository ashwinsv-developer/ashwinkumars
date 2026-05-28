

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Branding extends StatelessWidget {
  const Branding();
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text('blinkit',
          style: TextStyle(
              color: Colors.white.withOpacity(0.88),
              fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: .5)),
      const Text('MONEY',
          style: TextStyle(
              color: Colors.white, fontSize: 50,
              fontWeight: FontWeight.w900, letterSpacing: 3, height: 1.0)),
    ],
  );
}

class CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const CircleBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 44, height: 44,
      decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(22)),
      child: Icon(icon, color: Colors.white, size: 22),
    ),
  );
}
