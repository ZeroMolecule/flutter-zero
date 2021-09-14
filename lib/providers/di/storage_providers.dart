import 'package:flutter_zero/domain/local/auth_store.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStoreProvider = Provider((ref) => AuthStore(ref));
