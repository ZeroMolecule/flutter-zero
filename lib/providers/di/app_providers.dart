import 'package:device_info/device_info.dart';
import 'package:flutter_zero/flow/app/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (ref) => SharedPreferences.getInstance(),
);

final deviceInfoProvider = Provider((ref) => DeviceInfoPlugin());
final appThemeProvider = ChangeNotifierProvider((ref) => AppTheme());
