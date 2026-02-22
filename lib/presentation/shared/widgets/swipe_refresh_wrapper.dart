import 'package:flutter/material.dart';

class SwipeRefreshWrapper extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;
  final Color? color;
  final double edgeOffset;

  const SwipeRefreshWrapper({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.edgeOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? Theme.of(context).colorScheme.primary,
      edgeOffset: edgeOffset,
      child: child,
    );
  }
}
