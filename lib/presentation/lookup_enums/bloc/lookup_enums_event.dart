import 'package:equatable/equatable.dart';

abstract class LookupEnumsEvent extends Equatable {
  const LookupEnumsEvent();

  @override
  List<Object?> get props => [];
}

class LoadLookupEnumsEvent extends LookupEnumsEvent {
  const LoadLookupEnumsEvent();
}
