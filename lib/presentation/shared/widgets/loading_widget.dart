import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const LoadingWidget({super.key, this.size = 24, this.strokeWidth = 2.5, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Platform.isIOS
          ? CupertinoActivityIndicator(radius: (size / 2) + 2, color: color)
          : CircularProgressIndicator(strokeWidth: strokeWidth, color: color),
    );
  }
}
