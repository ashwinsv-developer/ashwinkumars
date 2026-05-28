import 'package:flutter/material.dart';
import 'feature/screen/paymentPaymentScreen.dart';
import 'feature/widget/BrandWidget.dart';
import 'feature/widget/DottedGradientBg.dart';
import 'feature/widget/SuccessContent.dart';
import 'feature/widget/logo.dart';
import 'feature/widget/painter.dart';


void main() {
  runApp(const BlinkitMoneyApp());
}

class BlinkitMoneyApp extends StatelessWidget {
  const BlinkitMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blinkit Money',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const BlinkitPaymentScreen(),
    );
  }
}







