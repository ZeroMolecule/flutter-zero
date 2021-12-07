import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Loading extends HookWidget {
  static Widget sliver({Key? key, Key? childKey, bool fill = true}) {
    final widget = Loading(key: childKey);
    if (fill) {
      return SliverFillRemaining(key: key, child: widget, hasScrollBody: false);
    }
    return SliverToBoxAdapter(key: key, child: widget);
  }

  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
