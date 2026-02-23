import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/dashboard/entities/dashboard_response.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitialState extends DashboardState {
  const DashboardInitialState();
}

class DashboardLoadingState extends DashboardState {
  const DashboardLoadingState();
}

class DashboardLoadedState extends DashboardState {
  final DashboardResponse dashboardData;

  const DashboardLoadedState({required this.dashboardData});

  @override
  List<Object?> get props => [dashboardData];
}

class DashboardErrorState extends DashboardState {
  final String message;

  const DashboardErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
