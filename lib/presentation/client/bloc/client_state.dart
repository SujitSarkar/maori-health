part of 'client_bloc.dart';

sealed class ClientState extends Equatable {
  const ClientState();

  @override
  List<Object> get props => [];
}

class ClientInitial extends ClientState {}

class ClientLoadingState extends ClientState {}

class ClientLoadedState extends ClientState {
  final List<Client> clients;

  const ClientLoadedState({required this.clients});

  @override
  List<Object> get props => [clients];
}

class ClientErrorState extends ClientState {
  final String message;

  const ClientErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
