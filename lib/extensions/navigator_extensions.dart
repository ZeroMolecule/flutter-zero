import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

extension NavigatorStateExtensions on NavigatorState {
  Future<T?> pushAndRemoveAll<T extends Object?>(Route<T> newRoute) {
    return pushAndRemoveUntil(newRoute, (route) => false);
  }
}

extension StackRouterExtensions on StackRouter {
  Future<bool> popOrReplaceAll<T extends Object?>(
    List<PageRouteInfo> routes, {
    T? result,
    OnNavigationFailure? onFailure,
  }) async {
    if (!canPopSelfOrChildren) {
      await replaceAll(routes, onFailure: onFailure);
      return true;
    } else {
      return pop(result);
    }
  }
}
