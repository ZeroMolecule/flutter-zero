import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zero/gen/colors.gen.dart';
import 'package:flutter_zero/hooks/theme_hook.dart';
import 'package:flutter_zero/widgets/dynamic_image.dart';

const _settings = RouteSettings(name: 'info-dialog');

class InfoDialog extends HookWidget {
  static Future<void> show(
    BuildContext context, {
    Color? barrierColor = ColorName.overlay,
    bool? barrierDismissible,
    // dialog props
    dynamic image,
    String? titleText,
    String? contentText,
    String? primaryText = 'OK',
    Function()? onPrimaryPressed,
    String? secondaryText,
    Function()? onSecondaryPressed,
  }) {
    print('Showing dialog...');
    dismiss(context);
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: InfoDialog(
          image: image,
          titleText: titleText,
          primaryText: primaryText,
          onPrimaryPressed: onPrimaryPressed,
          secondaryText: secondaryText,
          onSecondaryPressed: onSecondaryPressed,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      barrierColor: barrierColor,
      barrierDismissible:
          barrierDismissible ?? primaryText == null && secondaryText == null,
      useRootNavigator: true,
      routeSettings: _settings,
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).popUntil(
      (route) => route.settings.name != _settings.name,
    );
  }

  final dynamic image;

  final String? titleText;
  final String? contentText;

  final String? primaryText;
  final Function()? onPrimaryPressed;

  final String? secondaryText;
  final Function()? onSecondaryPressed;

  const InfoDialog({
    Key? key,
    this.image,
    this.titleText,
    this.contentText,
    this.primaryText,
    this.onPrimaryPressed,
    this.secondaryText,
    this.onSecondaryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = useTextTheme();

    final handlePrimaryPressed = useCallback(() {
      dismiss(context);
      onPrimaryPressed?.call();
    }, [onPrimaryPressed]);

    final handleSecondaryPressed = useCallback(() {
      dismiss(context);
      onSecondaryPressed?.call();
    }, [onSecondaryPressed]);

    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 12, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: DynamicImage.create(image),
            ),
          if (titleText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                titleText!,
                style: textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
          if (contentText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                contentText!,
                style: textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
          if (primaryText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ElevatedButton(
                onPressed: handlePrimaryPressed,
                child: Text(primaryText!),
              ),
            ),
          if (secondaryText != null)
            Padding(
              padding: EdgeInsets.zero,
              child: ElevatedButton(
                onPressed: handleSecondaryPressed,
                child: Text(secondaryText!),
              ),
            ),
        ],
      ),
    );
  }
}
