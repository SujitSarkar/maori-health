import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/employee/entities/employee.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeLoadingState extends EmployeeState {
  const EmployeeLoadingState();
}

class EmployeeLoadedState extends EmployeeState {
  final List<Employee> employees;

  const EmployeeLoadedState(this.employees);

  @override
  List<Object?> get props => [employees];
}

class EmployeeErrorState extends EmployeeState {
  final String message;

  const EmployeeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
