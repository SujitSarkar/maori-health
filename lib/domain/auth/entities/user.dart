import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? nickName;
  final String email;
  final String? phone;
  final String? location;
  final String? userType;
  final String? gender;
  final String? proNoun;
  final String? dob;
  final String? status;
  final String? age;
  final String? ageGroup;
  final String? avatar;
  final String? photoId;
  final String? nhi;
  final String? ethnicity;
  final int? teamId;
  final String? externalAccess;
  final String? limitedAccess;
  final String? externalLoginOtp;
  final String? externalLoginOtpExpiredAt;
  final int? operatorId;
  final String? emailVerifiedAt;
  final String? fullName;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const User({
    required this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.nickName,
    required this.email,
    this.phone,
    this.location,
    this.userType,
    this.gender,
    this.proNoun,
    this.dob,
    this.status,
    this.age,
    this.ageGroup,
    this.avatar,
    this.photoId,
    this.nhi,
    this.ethnicity,
    this.teamId,
    this.externalAccess,
    this.limitedAccess,
    this.externalLoginOtp,
    this.externalLoginOtpExpiredAt,
    this.operatorId,
    this.emailVerifiedAt,
    this.fullName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [id, email];
}
