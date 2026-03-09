import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maori_health/core/config/app_strings.dart';
import 'package:maori_health/domain/lookup_enums/usecases/get_lookup_enums_usecase.dart';
import 'package:maori_health/presentation/lookup_enums/bloc/lookup_enums_event.dart';
import 'package:maori_health/presentation/lookup_enums/bloc/lookup_enums_state.dart';

class LookupEnumsBloc extends Bloc<LookupEnumsEvent, LookupEnumsState> {
  final GetLookupEnumsUsecase _getLookupEnumsUsecase;

  LookupEnumsBloc({required GetLookupEnumsUsecase getLookupEnumsUsecase})
    : _getLookupEnumsUsecase = getLookupEnumsUsecase,
      super(const LookupEnumsLoadingState()) {
    on<LoadLookupEnumsEvent>(_onLoadLookupEnums);
  }

  Future<void> _onLoadLookupEnums(LoadLookupEnumsEvent event, Emitter<LookupEnumsState> emit) async {
    emit(const LookupEnumsLoadingState());
    final result = await _getLookupEnumsUsecase.call();

    await result.fold(
      onFailure: (error) async {
        emit(LookupEnumsErrorState(error.errorMessage ?? AppStrings.somethingWentWrong));
      },
      onSuccess: (lookupEnums) async {
        emit(LookupEnumsLoadedState(lookupEnums));
      },
    );
  }
}
