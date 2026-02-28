import 'package:flutter/material.dart';

import 'package:maori_health/presentation/shared/widgets/loading_widget.dart';

class PaginationWrapper extends StatefulWidget {
  final Widget child;
  final bool hasMore;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final double threshold;

  const PaginationWrapper({
    super.key,
    required this.child,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    this.threshold = 200,
  });

  @override
  State<PaginationWrapper> createState() => _PaginationWrapperState();
}

class _PaginationWrapperState extends State<PaginationWrapper> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: Column(
        children: [
          Expanded(child: widget.child),
          if (widget.isLoadingMore)
            const Padding(
              padding: .symmetric(vertical: 16),
              child: SizedBox(height: 24, width: 24, child: LoadingWidget()),
            ),
        ],
      ),
    );
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is! ScrollUpdateNotification) return false;

    final metrics = notification.metrics;
    if (metrics.pixels >= metrics.maxScrollExtent - widget.threshold) {
      if (widget.hasMore && !widget.isLoadingMore) {
        widget.onLoadMore();
      }
    }
    return false;
  }
}
