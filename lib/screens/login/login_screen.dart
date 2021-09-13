import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vc = useProvider(authViewControllerProvider);
    final session = useProvider(authProvider).state;

    useAsyncEffect(() => vc.init(), [vc]);

    print(session?.user.email);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () => vc.signIn('google'), child: Text('signIn')),
          ElevatedButton(onPressed: () => vc.signOut(), child: Text('signOut'))
        ],
      ),
    ));
  }
}
