import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Safe wrapper around [CachedNetworkImage] with URL validation and unified fallbacks.
///
/// Invalid URLs (empty, `-`, non-http(s)) never reach the cache layer, avoiding
/// crashes from malformed API values. Network failures reuse the same fallback chain.
class AppNetworkImage extends StatelessWidget {
  /// Mirrors [CachedNetworkImage] parameters for drop-in replacement.
  const AppNetworkImage({
    required this.imageUrl,
    super.key,
    this.httpHeaders,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.errorListener,
    this.scale = 1.0,
  });

  /// Removes a cached entry. Returns `false` when nothing was evicted.
  ///
  /// Delegates to [CachedNetworkImage.evictFromCache]; pass the same [cacheKey]
  /// and [scale] used when the image was loaded.
  static Future<bool> evictFromCache(
    String url, {
    String? cacheKey,
    double scale = 1,
  }) =>
      CachedNetworkImage.evictFromCache(
        url,
        cacheKey: cacheKey,
        scale: scale,
      );

  /// Returns `true` when [url] is safe to pass to [CachedNetworkImage].
  ///
  /// Rejects `null`, blank strings, placeholder `-`, missing scheme/host,
  /// and schemes other than `http` / `https`.
  static bool isValidImageUrl(String? url) {
    if (url == null) {
      return false;
    }

    final trimmed = url.trim();
    if (trimmed.isEmpty || trimmed == '-') {
      return false;
    }

    final uri = Uri.tryParse(trimmed);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
      return false;
    }

    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  final String imageUrl;
  final String? cacheKey;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Shown on invalid URL or load failure. Takes precedence over [placeholder].
  final LoadingErrorWidgetBuilder? errorWidget;
  final Duration? placeholderFadeInDuration;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final ValueChanged<Object>? errorListener;
  final double scale;

  /// Stand-in error when the URL fails validation before any network request.
  static const _invalidUrlError = FormatException('Invalid network image URL');

  @override
  Widget build(BuildContext context) {
    if (!isValidImageUrl(imageUrl)) {
      return _buildErrorFallback(context, null, null);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl.trim(),
      httpHeaders: httpHeaders,
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      progressIndicatorBuilder: progressIndicatorBuilder,
      errorBuilder: _buildErrorFallback,
      fadeOutDuration: fadeOutDuration,
      fadeOutCurve: fadeOutCurve,
      fadeInDuration: fadeInDuration,
      fadeInCurve: fadeInCurve,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      color: color,
      filterQuality: filterQuality,
      colorBlendMode: colorBlendMode,
      placeholderFadeInDuration: placeholderFadeInDuration,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      cacheKey: cacheKey,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      errorListener: errorListener,
      scale: scale,
    );
  }

  /// Fallback UI for invalid URLs and [CachedNetworkImage] load errors.
  ///
  /// Priority: [errorWidget] → [placeholder] → default error [Icon].
  /// Uses [_invalidUrlError] when [error] is null (pre-flight URL rejection).
  Widget _buildErrorFallback(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  ) {
    if (errorWidget != null) {
      return _constrainSize(
        errorWidget!(context, imageUrl, error ?? _invalidUrlError),
      );
    }

    if (placeholder != null) {
      return _constrainSize(placeholder!(context, imageUrl));
    }

    return _constrainSize(
      const Center(child: Icon(Icons.error)),
    );
  }

  /// Applies [width] and [height] so fallbacks match the requested image bounds.
  Widget _constrainSize(Widget child) =>
      SizedBox(width: width, height: height, child: child);
}
