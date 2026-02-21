import 'package:equatable/equatable.dart';

enum DashboardStatus { initial, loading, loaded, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final String? errorMessage;

  const DashboardState({this.status = DashboardStatus.initial, this.errorMessage});

  DashboardState copyWith({DashboardStatus? status, String? errorMessage}) {
    return DashboardState(status: status ?? this.status, errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
