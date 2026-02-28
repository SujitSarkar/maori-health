part of 'client_bloc.dart';

sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class LoadClientsEvent extends ClientEvent {
  final int page;

  const LoadClientsEvent({this.page = 1});

  @override
  List<Object> get props => [page];
}
