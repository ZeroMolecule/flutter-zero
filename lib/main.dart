import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/providers/navigation_providers.dart';
import 'package:flutter_zero/screens/splash/splash_screen.dart';
import 'package:flutter_zero/util/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Env.ensureInitialized();
  runApp(ProviderScope(child: App()));
}

class App extends HookWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read(appRouterProvider);
    return MaterialApp.router(
      theme: ThemeData(primarySwatch: Colors.amber),
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        placeholder: (context) => const SplashScreen(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
    );
  }
}
