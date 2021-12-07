import 'package:auto_route/auto_route.dart';
import 'package:flutter_zero/providers/config_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfigGuard extends AutoRouteGuard {
  final Ref _ref;
  late final ConfigProvider _configProvider = _ref.read(configProvider);

  ConfigGuard(this._ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    await _configProvider.init();
    resolver.next();
  }
}
