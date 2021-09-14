import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:flutter_zero/screens/home/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_zero/extensions/navigator_state.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useMemoized(() => TextEditingController());
    final passwordController = useMemoized(() => TextEditingController());
    final viewController = useProvider(authViewControllerProvider);
    final status = useProvider(authStatusProvider).state;
    final session = useProvider(authProvider).state;

    useAsyncEffect(() {
      if (status == Status.fulfilled && session != null) {
        Navigator.of(context).pushAndRemoveAll(
          MaterialPageRoute(builder: (BuildContext ctx) => const HomeScreen()),
        );
      }
    }, [status, session]);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () => viewController.socialSignIn('google'),
              child: Text('Google')),
          ElevatedButton(
              onPressed: () => viewController.socialSignIn('facebook'),
              child: Text('Facebook')),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(hintText: 'Password'),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    viewController.localSignIn(
                        identifier: emailController.text,
                        password: passwordController.text);
                  },
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
