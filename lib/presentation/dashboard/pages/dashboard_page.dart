import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.dashboard)),
      body: const Center(
        child: Text(StringConstants.dashboard, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
