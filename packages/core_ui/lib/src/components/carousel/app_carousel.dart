import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Themed banner carousel with optional page indicator dots.
///
/// Combines [CarouselSlider] and [AnimatedSmoothIndicator] with design tokens.
/// Auto-play is enabled by default when there is more than one slide.
class AppCarousel extends StatefulWidget {
  const AppCarousel({
    required this.items,
    required this.height,
    super.key,
    this.autoPlay,
    this.viewportFraction = 1,
    this.enlargeCenterPage = false,
    this.showIndicator = true,
    this.borderRadius,
    this.onPageChanged,
    this.controller,
  }) : assert(items.length > 0, 'items must not be empty');

  /// Carousel slide widgets.
  final List<Widget> items;

  /// Fixed height of the carousel viewport.
  final double height;

  /// Enables auto-play. Defaults to true when there is more than one slide.
  final bool? autoPlay;

  /// Fraction of viewport each page occupies (1.0 = full width).
  final double viewportFraction;

  /// Whether the center page is enlarged for a depth effect.
  final bool enlargeCenterPage;

  /// Shows dot indicator below the carousel. Hidden when only one item.
  final bool showIndicator;

  /// Clips slides with this radius. Defaults to [AppRadius.image] at full width.
  final BorderRadius? borderRadius;

  /// Called when the active page index changes.
  final ValueChanged<int>? onPageChanged;

  /// Optional controller for programmatic navigation.
  final CarouselSliderController? controller;

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  late final CarouselSliderController _controller;
  int _currentIndex = 0;

  bool get _shouldAutoPlay => widget.autoPlay ?? widget.items.length > 1;

  bool get _shouldShowIndicator =>
      widget.showIndicator && widget.items.length > 1;

  BorderRadius get _borderRadius =>
      widget.borderRadius ??
      (widget.viewportFraction >= 1 ? AppRadius.image : BorderRadius.zero);

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.colorTokens;

    var options = CarouselOptions(
      height: widget.height,
      viewportFraction: widget.viewportFraction,
      autoPlay: _shouldAutoPlay,
      onPageChanged: (index, reason) {
        setState(() => _currentIndex = index);
        widget.onPageChanged?.call(index);
      },
    );

    if (widget.enlargeCenterPage) {
      options = options.copyWith(enlargeCenterPage: true);
    }
    if (widget.items.length <= 1) {
      options = options.copyWith(enableInfiniteScroll: false);
    }

    final carousel = CarouselSlider(
      items: widget.items,
      controller: _controller,
      options: options,
    );

    final clippedCarousel = ClipRRect(
      borderRadius: _borderRadius,
      child: carousel,
    );

    if (!_shouldShowIndicator) {
      return clippedCarousel;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        clippedCarousel,
        const SizedBox(height: AppSpacing.sm),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: widget.items.length,
          effect: WormEffect(
            dotWidth: 8,
            dotHeight: 8,
            spacing: AppSpacing.xs,
            radius: 4,
            dotColor: tokens.outlineVariant,
            activeDotColor: tokens.primary,
          ),
          onDotClicked: (index) => _controller.animateToPage(index),
        ),
      ],
    );
  }
}
