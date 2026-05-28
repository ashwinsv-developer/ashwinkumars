

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BrandWidget.dart';
import 'cards/feature_card.dart';
import 'cards/gift_card_row.dart';
import 'logo.dart';

class SuccessContent extends StatelessWidget {
  final Alignment walletAlign;
  final double    walletScale;
  final double    brandFade;
  final Offset    brandSlide;
  final List<double> cardFades;
  final List<Offset> cardSlides;
  final double    bottomFade;
  final Offset    bottomSlide;

  const SuccessContent({
    required this.walletAlign,
    required this.walletScale,
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
              child: Transform.scale(
                scale: walletScale,
                child: BlinkitLogo(),
              ),
            ),
      
            // ── scrollable content column ───────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        title: 'Single tap payments',
                        subtitle: 'Enjoy seamless payments without the wait for OTPs',
                      ),
                      const FeatureData(
                        icon: Icons.wifi_outlined,
                        title: 'Zero failures',
                        subtitle: 'Zero payment failures ensure you never miss an order',
                      ),
                      const FeatureData(
                        icon: Icons.replay_outlined,
                        title: 'Real-time refunds',
                        subtitle: 'No need to wait for refunds. Blinkit Money refunds are instant!',
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
                                backgroundColor: const Color(0xFF3BAD3B),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: const Text('Add Money',
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.w700)),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const GiftCardRow(),
                          const SizedBox(height: 20),
                          Text(
                            'Enjoy seamless\none tap payments',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF4A4530).withOpacity(0.85),
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
