import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/gen/assets.gen.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.app.splash.image(
          fit: BoxFit.scaleDown,
          width: 240,
        ),
      ),
    );
  }
}
