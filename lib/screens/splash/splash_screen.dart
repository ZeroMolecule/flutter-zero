import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:flutter_zero/screens/home/home_screen.dart';
import 'package:flutter_zero/screens/login/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_zero/extensions/navigator_state.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewController = useProvider(authViewControllerProvider);
    final status = useProvider(authStatusProvider).state;
    final session = useProvider(authProvider).state;

    useAsyncEffect(() => viewController.init(), [viewController]);

    useAsyncEffect(() {
      if (status == Status.fulfilled) {
        Navigator.of(context).pushAndRemoveAll(
          MaterialPageRoute(
              builder: (BuildContext ctx) =>
                  session == null ? const LoginScreen() : const HomeScreen()),
        );
      }
    }, [status, session]);

    return const Scaffold();
  }
}
