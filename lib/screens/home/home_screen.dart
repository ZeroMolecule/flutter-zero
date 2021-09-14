import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:flutter_zero/screens/login/login_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_zero/extensions/navigator_state.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewController = useProvider(authViewControllerProvider);
    final status = useProvider(authStatusProvider).state;
    final session = useProvider(authProvider).state;

    useAsyncEffect(() {
      if (status == Status.fulfilled && session == null) {
        Navigator.of(context).pushAndRemoveAll(
          MaterialPageRoute(builder: (BuildContext ctx) => const LoginScreen()),
        );
      }
    }, [status, session]);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(session?.user.email ?? ''),
          Text(session?.user.provider ?? ''),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: () => viewController.signOut(),
          )
        ],
      ),
    ));
  }
}
