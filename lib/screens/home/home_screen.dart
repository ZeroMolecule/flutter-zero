import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/domain/data/auth_provider.dart';
import 'package:flutter_zero/hooks/translation_hook.dart';
import 'package:flutter_zero/hooks/util.dart';
import 'package:flutter_zero/navigation/app_router.gr.dart';
import 'package:flutter_zero/providers/auth_provider.dart';
import 'package:flutter_zero/providers/state/status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translation = useTranslation();
    final viewController = useProvider(authViewControllerProvider);
    final status = useProvider(authStatusProvider).state;
    final session = useProvider(authProvider).state;

    useAsyncEffect(() {
      if (status == Status.fulfilled && session == null) {
        AutoRouter.of(context).replaceAll([const HomeRoute()]);
      }
    }, [status, session]);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(session?.user.email ?? ''),
            Text(session?.user.provider.key ?? ''),
            ElevatedButton(
              onPressed: () => viewController.signOut(),
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () => AutoRouter.of(context).navigate(
                PokemonDetailsRoute(pokemonId: Random().nextInt(150) + 1),
              ),
              child: Text(translation.randomPokemon),
            ),
          ],
        ),
      ),
    );
  }
}
