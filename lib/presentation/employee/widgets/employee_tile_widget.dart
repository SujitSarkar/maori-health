import 'package:flutter/material.dart' show ListTile;
import 'package:flutter/widgets.dart';

import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/domain/employee/entities/employee.dart';

class EmployeeTileWidget extends StatelessWidget {
  final Employee employee;

  const EmployeeTileWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(employee.fullName, style: context.textTheme.bodyMedium?.copyWith(fontWeight: .w600)),
      subtitle: Text(
        employee.location ?? employee.userType,
        style: context.textTheme.bodySmall?.copyWith(color: context.theme.hintColor),
      ),
    );
  }
}
