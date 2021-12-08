import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/gen/colors.gen.dart';
import 'package:flutter_zero/widgets/loading.dart';

class LoadingOverlay extends HookWidget {
  static OverlayEntry? _entry;

  static void show(BuildContext context) {
    dismiss();

    final overlay = Overlay.of(context, rootOverlay: true);
    if (overlay != null) {
      final entry = OverlayEntry(
        builder: (context) => const LoadingOverlay(),
        maintainState: false,
      );
      overlay.insert(entry);
      _entry = entry;
    }
  }

  static void dismiss() {
    _entry?.remove();
    _entry = null;
  }

  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: ColorName.overlay,
      child: Loading(),
    );
  }
}
