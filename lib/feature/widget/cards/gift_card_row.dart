import 'package:flutter/material.dart';
import '../../../core/app_colour.dart';
import '../../../core/app_constants.dart';

class GiftCardRow extends StatelessWidget {
  const GiftCardRow({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.cardBorder),
    ),
    child: Row(children: [
      Container(
        width: 48, height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              colors: [AppColors.accentYellow, AppColors.accentYellowDark],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: const Icon(Icons.card_giftcard, color: Colors.white, size: 26),
      ),
      const SizedBox(width: 14),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(AppStrings.claimGiftCard,
              style: TextStyle(color: Colors.white, fontSize: 14,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(AppStrings.claimGiftCardSubtitle,
              style: TextStyle(color: Colors.white.withOpacity(0.5),
                  fontSize: 12)),
        ],
      )),
      const Icon(Icons.chevron_right, color: Colors.white54, size: 22),
    ]),
  );
}
