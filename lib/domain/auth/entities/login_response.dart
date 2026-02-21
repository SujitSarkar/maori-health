import 'package:equatable/equatable.dart';

import 'package:maori_health/domain/auth/entities/user.dart';

class LoginResponse extends Equatable {
  final String accessToken;
  final String tokenType;
  final User user;

  const LoginResponse({required this.accessToken, required this.tokenType, required this.user});

  @override
  List<Object?> get props => [accessToken, tokenType, user];
}
