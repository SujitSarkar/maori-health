import 'package:equatable/equatable.dart';

class ScheduleStatus extends Equatable {
  final String? active;
  final String? cancelled;
  final String? completed;
  final String? finished;
  final String? inprogress;
  final String? parked;

  const ScheduleStatus({this.active, this.cancelled, this.completed, this.finished, this.inprogress, this.parked});

  @override
  List<Object?> get props => [active, cancelled, completed, finished, inprogress, parked];
}
