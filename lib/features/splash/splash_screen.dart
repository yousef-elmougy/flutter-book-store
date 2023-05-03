import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/assets.dart';
import '../../core/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _delay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  Future<void> _delay() async =>
      _timer = Timer(const Duration(seconds: 3), _navigateTo);

  void _navigateTo() => context.go(AppRouter.layoutScreen);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(Assets.logo, height: 50),
            const SizedBox(height: 20),
            const Text(
              'Welcome in Bookly store',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
