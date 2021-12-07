import 'package:auto_route/auto_route.dart';

const _splashDuration = Duration(seconds: 2);

class SplashGuard extends AutoRouteGuard {
  final DateTime _splashStart = DateTime.now();

  Future<void> _splash() async {
    final passedDuration = _splashStart.difference(DateTime.now()).abs();
    final passedMs = passedDuration.inMilliseconds;
    final diffMs = _splashDuration.inMilliseconds - passedMs;
    if (diffMs > 0) {
      await Future.delayed(Duration(milliseconds: diffMs));
    }
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    await _splash();
    resolver.next();
  }
}
