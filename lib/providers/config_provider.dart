import 'package:flutter/material.dart';
import 'package:flutter_zero/extensions/change_notifier_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final configProvider = ChangeNotifierProvider((ref) => ConfigProvider(ref));

class ConfigProvider with ChangeNotifier {
  final Ref _ref;

  AsyncValue<PackageInfo> _packageInfo = const AsyncValue.loading();

  ConfigProvider(this._ref);

  String get appVersion => _packageInfo.value!.version;

  String get appName => _packageInfo.value!.appName;

  String get buildNumber => _packageInfo.value!.buildNumber;

  Future<void> init() async {
    if (_packageInfo.value == null) {
      await asyncFetch<PackageInfo>(
        (value) => _packageInfo = value,
        fetch: PackageInfo.fromPlatform,
      );
    }
  }
}
