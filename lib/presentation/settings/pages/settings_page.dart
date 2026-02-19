import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.settings)),
      body: const Center(
        child: Text(StringConstants.settings, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
