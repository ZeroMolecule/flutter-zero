import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zero/gen/assets.gen.dart';

class DynamicImage {
  static ImageProvider provider(
    dynamic src, {
    bool cache = true,
    double? scale,
    AssetBundle? bundle,
    String? package,
    Map<String, String>? headers,
    String? cacheKey,
  }) {
    if (src is String) {
      final uri = Uri.tryParse(src);
      if (uri != null) {
        if (uri.hasScheme && uri.scheme.toLowerCase().startsWith('http')) {
          // todo: check if cache or not
          return NetworkImage(
            uri.toString(),
            scale: scale ?? 1.0,
            headers: headers,
          );
        }
        try {
          final file = File.fromUri(uri);
          return FileImage(file, scale: scale ?? 1.0);
          // ignore: empty_catches
        } catch (e) {}
      } else {
        if (scale != null) {
          return ExactAssetImage(
            src,
            bundle: bundle,
            scale: scale,
            package: package,
          );
        } else {
          return AssetImage(
            src,
            bundle: bundle,
            package: package,
          );
        }
      }
    } else if (src is File) {
      return FileImage(src, scale: scale ?? 1.0);
    }
    throw FlutterError('Could not find a provider for $src');
  }

  static Widget create(
    dynamic src, {
    Key? key,
    double? scale,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    FilterQuality filterQuality = FilterQuality.low,
    bool isAntiAlias = false,
    // network image
    Map<String, String>? headers,
    int? cacheWidth,
    int? cacheHeight,
    // asset image
    AssetBundle? bundle,
    String? package,
    bool cache = true,
    // cache
    String? cacheKey,
    // svg
    WidgetBuilder? placeholderBuilder,
    Clip clipBehavior = Clip.hardEdge,
    bool allowDrawingOutsideViewBox = false,
    // iconData
    double? size,
    TextDirection? textDirection,
  }) {
    if (width == null && height == null) {
      width = size;
      height = size;
    }
    if (src is IconData) {
      return Icon(
        src,
        color: color,
        size: size,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
      );
    }
    if (src is SvgGenImage) {
      return src.svg(
        key: key,
        package: package,
        bundle: bundle,
        width: width,
        fit: fit ?? BoxFit.contain,
        height: height,
        color: color,
        alignment: alignment,
        allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
        clipBehavior: clipBehavior,
        colorBlendMode: colorBlendMode ?? BlendMode.srcIn,
        excludeFromSemantics: excludeFromSemantics,
        matchTextDirection: matchTextDirection,
        placeholderBuilder: placeholderBuilder,
        semanticsLabel: semanticLabel,
      );
    }
    final image = src is ImageProvider
        ? src
        : provider(
            src,
            scale: scale,
            headers: headers,
            bundle: bundle,
            cache: cache,
            package: package,
            cacheKey: cacheKey,
          );
    return Image(
      image: image,
      matchTextDirection: matchTextDirection,
      repeat: repeat,
      opacity: opacity,
      isAntiAlias: isAntiAlias,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
      excludeFromSemantics: excludeFromSemantics,
      colorBlendMode: colorBlendMode,
      centerSlice: centerSlice,
      color: color,
      alignment: alignment,
      fit: fit,
      frameBuilder: frameBuilder,
      semanticLabel: semanticLabel,
      key: key,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      loadingBuilder: loadingBuilder,
    );
  }
}
