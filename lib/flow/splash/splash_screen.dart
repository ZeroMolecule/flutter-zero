import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Flutter Zero',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
