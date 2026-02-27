import 'package:maori_health/data/auth/models/user_model.dart';
import 'package:maori_health/domain/auth/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({required super.accessToken, required super.tokenType, required UserModel super.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return LoginResponseModel(
      accessToken: data['access_token']?.toString() ?? '',
      tokenType: data['token_type']?.toString() ?? '',
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
    );
  }
}
