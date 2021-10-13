import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Rejected extends HookWidget {
  final dynamic error;

  const Rejected({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline_rounded, color: Colors.red, size: 36),
        const SizedBox(height: 16),
        Text(error?.toString() ?? 'Something went wrong'),
      ],
    );
  }
}
