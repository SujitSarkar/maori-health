import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/lookup_enums/entities/lookup_enums.dart';

abstract class LookupEnumsState extends Equatable {
  const LookupEnumsState();

  @override
  List<Object?> get props => [];
}

class LookupEnumsLoadingState extends LookupEnumsState {
  const LookupEnumsLoadingState();
}

class LookupEnumsLoadedState extends LookupEnumsState {
  final LookupEnums lookupEnums;

  const LookupEnumsLoadedState(this.lookupEnums);

  @override
  List<Object?> get props => [lookupEnums];
}

class LookupEnumsErrorState extends LookupEnumsState {
  final String message;

  const LookupEnumsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
