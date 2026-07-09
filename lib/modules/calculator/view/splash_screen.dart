import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../calculator/view/calculator_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(
              () => const CalculatorPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Image(
          image: AssetImage(
            "assets/images/splashscreen.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}