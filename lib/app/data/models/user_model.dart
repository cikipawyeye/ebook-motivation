import 'package:ebookapp/core/constants/constant.dart';

class UserResponse {
  final User user;
  final String? token; // Make optional
  final String? message; // Make optional

  UserResponse({
    required this.user,
    this.token,
    this.message,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json['data']), // Changed from json['data']['user']
      token: json['data']['token'],
      message: json['message'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final bool isPremium;
  final String phoneNumber;
  final String birthDate;
  final int jobType; // Ubah menjadi int
  final String? job; // Make optional since it can be null
  final String gender;
  final String cityCode;
  final String createdAt;
  final City city;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.isPremium,
    required this.phoneNumber,
    required this.birthDate,
    required this.jobType,
    this.job, // Made optional
    required this.gender,
    required this.cityCode,
    required this.createdAt,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      isPremium: json['is_premium'] ?? false,
      phoneNumber: json['phone_number'],
      birthDate: json['birth_date'],
      jobType: int.tryParse(json['job_type']?.toString() ?? '0') ??
          0, // Ubah menjadi int
      job: json['job'] != null
          ? json['job']?.toString()
          : userJob[json['job_type'].toString()],
      gender: json['gender'],
      cityCode: json['city_code']?.toString() ?? '',
      createdAt: json['created_at'],
      city: City.fromJson(json['city']),
    );
  }
}

class City {
  final String id;
  final String name;
  final String code;
  final String provinceCode;
  final Meta meta;

  City({
    required this.id,
    required this.name,
    required this.code,
    required this.provinceCode,
    required this.meta,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      provinceCode: json['province_code'],
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meta {
  final String lat;
  final String long;

  Meta({
    required this.lat,
    required this.long,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      lat: json['lat'],
      long: json['long'],
    );
  }
}
