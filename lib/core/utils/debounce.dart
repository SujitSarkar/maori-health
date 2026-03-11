import 'package:flutter/foundation.dart';
import 'dart:async';

class Debounce {
  final int delayMilliseconds = 500;
  Timer? _timer;

  void run(VoidCallback action, {int? delayMilliseconds}) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: delayMilliseconds ?? this.delayMilliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
