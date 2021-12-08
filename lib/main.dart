import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zero/flow/splash/splash_screen.dart';
import 'package:flutter_zero/gen/l10n.dart';
import 'package:flutter_zero/providers/di/app_providers.dart';
import 'package:flutter_zero/providers/navigation_providers.dart';
import 'package:flutter_zero/util/env.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await Env.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(appRouterProvider);
    final appTheme = ref.watch(appThemeProvider);
    return MaterialApp.router(
      theme: appTheme.data,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        placeholder: (context) => const SplashScreen(),
      ),
      localizationsDelegates: const [AppTranslations.delegate],
      supportedLocales: AppTranslations.delegate.supportedLocales,
      onGenerateTitle: (context) => AppTranslations.of(context).appName,
    );
  }
}
