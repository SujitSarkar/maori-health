import 'package:flutter/material.dart';

class TopSnackBar extends StatefulWidget {
  final String message;
  final bool isError;
  final VoidCallback onDismiss;

  const TopSnackBar({super.key, required this.message, required this.isError, required this.onDismiss});

  @override
  State<TopSnackBar> createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    Future.delayed(const Duration(seconds: 3), _dismiss);
  }

  void _dismiss() {
    if (!mounted) return;
    _controller.reverse().then((_) {
      if (mounted) widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      top: MediaQuery.of(context).padding.top + 8,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          elevation: 6,
          borderRadius: .circular(8),
          color: widget.isError ? theme.colorScheme.error : theme.colorScheme.inverseSurface,
          child: Padding(
            padding: const .symmetric(horizontal: 16, vertical: 12),
            child: Text(
              widget.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: widget.isError ? theme.colorScheme.onError : theme.colorScheme.onInverseSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
