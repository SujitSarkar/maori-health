import 'package:flutter/material.dart';

import 'package:maori_health/core/config/string_constants.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.notification)),
      body: const Center(
        child: Text(StringConstants.notification, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
