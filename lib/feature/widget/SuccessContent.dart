

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/app_colour.dart';
import '../../core/app_constants.dart';

import 'BrandWidget.dart';
import 'cards/feature_card.dart';
import 'cards/gift_card_row.dart';
import 'logo.dart';

class SuccessContent extends StatelessWidget {
  final Alignment walletAlign;
  final double    brandFade;
  final Offset    brandSlide;
  final List<double> cardFades;
  final List<Offset> cardSlides;
  final double    bottomFade;
  final Offset    bottomSlide;

  const SuccessContent({
    required this.walletAlign,

    required this.brandFade,
    required this.brandSlide,
    required this.cardFades,
    required this.cardSlides,
    required this.bottomFade,
    required this.bottomSlide,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            // ── wallet floating up ──────────────────────
            SizedBox(height: 60,),
            Align(
              alignment: walletAlign,
              child: BlinkitLogo(),
            ),
      
            // ── scrollable content column ───────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  // space for wallet at top
                  // branding
                  FadeTransition(
                    opacity: AlwaysStoppedAnimation(brandFade),
                    child: SlideTransition(
                      position: AlwaysStoppedAnimation(brandSlide),
                      child: const Branding(),
                    ),
                  ),
      
                  const SizedBox(height: 28),
      
                  // feature cards
                  ...List.generate(3, (i) {
                    final features = [
                      const FeatureData(
                        icon: Icons.touch_app_outlined,
                        title: AppStrings.feature1Title,
                        subtitle: AppStrings.feature1Subtitle,
                      ),
                      const FeatureData(
                        icon: Icons.wifi_outlined,
                        title: AppStrings.feature2Title,
                        subtitle: AppStrings.feature2Subtitle,
                      ),
                      const FeatureData(
                        icon: Icons.replay_outlined,
                        title: AppStrings.feature3Title,
                        subtitle: AppStrings.feature3Subtitle,
                      ),
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FadeTransition(
                        opacity: AlwaysStoppedAnimation(cardFades[i]),
                        child: SlideTransition(
                          position: AlwaysStoppedAnimation(cardSlides[i]),
                          child: FeatureCard(data: features[i]),
                        ),
                      ),
                    );
                  }),
      
                  // bottom elements
                  FadeTransition(
                    opacity: AlwaysStoppedAnimation(bottomFade),
                    child: SlideTransition(
                      position: AlwaysStoppedAnimation(bottomSlide),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: const Text(AppStrings.addMoney,
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w700)),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const GiftCardRow(),
                          const SizedBox(height: 20),
                          Text(
                            AppStrings.footerMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.footerText.withOpacity(0.85),
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

