import 'package:flutter/material.dart';
import '../../../core/Constants.dart';

class FeatureData {
  final IconData icon;
  final String title, subtitle;
  const FeatureData({required this.icon, required this.title, required this.subtitle});
}

class FeatureCard extends StatelessWidget {
  final FeatureData data;
  const FeatureCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: AppColors.iconBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.iconBorder),
            ),
            child: Stack(alignment: Alignment.center, children: [
              Icon(Icons.smartphone_outlined,
                  color: Colors.white.withOpacity(0.85), size: 36),
              Positioned(
                right: 8, bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(data.icon, color: Colors.black, size: 13),
                ),
              ),
            ]),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(data.subtitle,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.55), fontSize: 12.5, height: 1.4)),
            ],
          )),
        ],
      ),
    );
  }
}
