import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/BrandWidget.dart';
import '../widget/DottedGradientBg.dart';
import '../widget/SuccessContent.dart';
import '../widget/logo.dart';
import '../widget/painter.dart';

// ═══════════════════════════════════════════════
//  MAIN SCREEN  (all phases handled here)
// ═══════════════════════════════════════════════
class BlinkitPaymentScreen extends StatefulWidget {
  const BlinkitPaymentScreen({super.key});

  @override
  State<BlinkitPaymentScreen> createState() => _BlinkitPaymentScreenState();
}

class _BlinkitPaymentScreenState extends State<BlinkitPaymentScreen>
    with TickerProviderStateMixin {

  // ── Phase 1: poppers + wallet entrance ──────────────────
  late AnimationController _popperCtrl;   // fires left & right cannon
  late AnimationController _walletCtrl;   // wallet scale-in
  late AnimationController _confettiCtrl; // confetti lifespan

  // ── Phase 2: wallet floats up, content slides in ─────────
  late AnimationController _transCtrl;    // drives the full phase-2

  // wallet position: centre → upper area
  late Animation<Alignment> _walletAlign;
  // wallet scale: 1.0 → 0.82 (slightly smaller when at top)
  late Animation<double> _walletShrink;

  // branding fade + slide
  late Animation<double>   _brandFade;
  late Animation<Offset>   _brandSlide;

  // each feature card staggered
  final List<Animation<double>>  _cardFade  = [];
  final List<Animation<Offset>>  _cardSlide = [];

  // bottom elements (button + gift card + footer text)
  late Animation<double>  _bottomFade;
  late Animation<Offset>  _bottomSlide;

  bool _phase2Started = false;

  @override
  void initState() {
    super.initState();

    _popperCtrl   = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _walletCtrl   = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    _confettiCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    _transCtrl    = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));

    // ── wallet alignment animation (phase 2) ─────────────
    _walletAlign = AlignmentTween(
      begin: Alignment.center,
      end: const Alignment(0, -0.68),
    ).animate(CurvedAnimation(
      parent: _transCtrl,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
    ));

    _walletShrink = Tween<double>(begin: 1.0, end: 0.78).animate(
      CurvedAnimation(parent: _transCtrl,
          curve: const Interval(0.0, 0.75, curve: Curves.easeInOut)),
    );

    // ── branding text ─────────────────────────────────────
    _brandFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _transCtrl,
          curve: const Interval(0.28, 0.55, curve: Curves.easeOut)),
    );
    _brandSlide = Tween<Offset>(
      begin: const Offset(0, 0.6), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _transCtrl,
        curve: const Interval(0.28, 0.55, curve: Curves.easeOut)));

    // ── feature cards (3) ─────────────────────────────────
    const cardStarts = [0.45, 0.56, 0.67];
    for (int i = 0; i < 3; i++) {
      final s = cardStarts[i];
      _cardFade.add(Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _transCtrl,
              curve: Interval(s, s + 0.22, curve: Curves.easeOut))));
      _cardSlide.add(Tween<Offset>(
        begin: const Offset(0, 0.7), end: Offset.zero,
      ).animate(CurvedAnimation(parent: _transCtrl,
          curve: Interval(s, s + 0.22, curve: Curves.easeOut))));
    }

    // ── bottom elements ───────────────────────────────────
    _bottomFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _transCtrl,
          curve: const Interval(0.78, 1.0, curve: Curves.easeOut)),
    );
    _bottomSlide = Tween<Offset>(
      begin: const Offset(0, 0.5), end: Offset.zero,
    ).animate(CurvedAnimation(parent: _transCtrl,
        curve: const Interval(0.78, 1.0, curve: Curves.easeOut)));

    _runSequence();
  }

  Future<void> _runSequence() async {
    // tiny delay, then shoot poppers + wallet entrance simultaneously
    await Future.delayed(const Duration(milliseconds: 1500));
    _popperCtrl.forward();
    _walletCtrl.forward();
    _confettiCtrl.forward(); // Fire single burst

    // Wait for the single burst and wallet to settle before transitioning
    await Future.delayed(const Duration(milliseconds: 3500));
    if (!mounted) return;
    setState(() => _phase2Started = true);
    _transCtrl.forward();
  }

  @override
  void dispose() {
    _popperCtrl.dispose();
    _walletCtrl.dispose();
    _confettiCtrl.dispose();
    _transCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── background ─────────────────────────────────
          const DottedGradientBg(),

          // ── confetti (phase 1) ─────────────────────────
          AnimatedBuilder(
            animation: _confettiCtrl,
            builder: (_, __) => CustomPaint(
              painter: ConfettiPainter(_confettiCtrl.value),
              size: size,
            ),
          ),

          // ── PHASE 1: wallet centered ───────────────────
          if (!_phase2Started)
            AnimatedBuilder(
              animation: _walletCtrl,
              builder: (_, __) {
                final scale = CurvedAnimation(
                    parent: _walletCtrl, curve: Curves.elasticOut)
                    .value;
                final rot = Tween<double>(begin: -0.12, end: 0.0)
                    .animate(CurvedAnimation(
                    parent: _walletCtrl, curve: Curves.easeOut))
                    .value;
                return Align(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: rot,
                    child: Transform.scale(
                      scale: scale,

                      child: BlinkitLogo(),
                    ),
                  ),
                );
              },
            ),

          // ── PHASE 2: full layout with animations ───────
          if (_phase2Started)
            AnimatedBuilder(
              animation: _transCtrl,
              builder: (_, __) => SuccessContent(
                walletAlign:  _walletAlign.value,
                walletScale:  _walletShrink.value,
                brandFade:    _brandFade.value,
                brandSlide:   _brandSlide.value,
                cardFades:    _cardFade.map((a) => a.value).toList(),
                cardSlides:   _cardSlide.map((a) => a.value).toList(),
                bottomFade:   _bottomFade.value,
                bottomSlide:  _bottomSlide.value,
              ),
            ),

          // ── top nav (always visible) ───────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleBtn(icon: Icons.chevron_left, onTap: () {}),
                  if (_phase2Started)
                    CircleBtn(icon: Icons.settings_outlined, onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
