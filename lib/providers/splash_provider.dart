import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final splashProvider = ChangeNotifierProvider((ref) => SplashProvider());

class SplashProvider with ChangeNotifier {
  static const Duration _splashDuration = Duration(seconds: 2);
  late DateTime _splashStart;

  SplashProvider() {
    _splashStart = DateTime.now();
  }

  Future<void> splash() async {
    final passedTime = _splashStart.difference(DateTime.now()).abs();
    final passedMilliseconds = _splashDuration.inMilliseconds;
    final splashMilliseconds = passedTime.inMilliseconds;
    final diffMilliseconds = splashMilliseconds - passedMilliseconds;
    if (diffMilliseconds > 0) {
      await Future.delayed(Duration(milliseconds: diffMilliseconds));
    }
  }
}
