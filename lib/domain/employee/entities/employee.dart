import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? nickName;
  final String? email;
  final String? phone;
  final String? location;
  final String userType;
  final String? gender;
  final String? dob;
  final String status;
  final String? age;
  final String? ageGroup;
  final String? avatar;
  final int? photoId;
  final String? nhi;
  final String? ethnicity;
  final int? teamId;
  final String? externalAccess;
  final String? limitedAccess;
  final String? externalLoginOtp;
  final String? externalLoginOtpExpiredAt;
  final int? operatorId;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String fullName;

  const Employee({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.nickName,
    this.email,
    this.phone,
    this.location,
    required this.userType,
    this.gender,
    this.dob,
    required this.status,
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.fullName,
  });

  @override
  List<Object?> get props => [id, fullName];
}
