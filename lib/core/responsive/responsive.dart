import 'package:flutter/material.dart';

class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1240;
}
extension ContextSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  bool get isMobile => screenWidth < Breakpoints.mobile;
  bool get isTablet => screenWidth >= Breakpoints.mobile && screenWidth < Breakpoints.tablet;
  bool get isDesktop => screenWidth >= Breakpoints.tablet;
}

/// Common responsive padding
EdgeInsets responsivePadding(BuildContext context) {
  if (context.isDesktop) return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
  if (context.isTablet) return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
  return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
}



/// Optional max width container to keep content readable on ultra-wide screens
class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child, this.max = 1200});
  final Widget child;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: max),
        child: child,
      ),
    );
  }
}
