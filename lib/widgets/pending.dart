import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Pending extends HookWidget {
  final String? message;

  const Pending({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        if (message != null) ...[const SizedBox(height: 16), Text(message!)],
      ],
    );
  }
}
