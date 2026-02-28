import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.schedule)),
      body: const Center(
        child: Text(StringConstants.schedule, style: TextStyle(fontSize: 24, fontWeight: .w600)),
      ),
    );
  }
}
