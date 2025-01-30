class UserResponse {
  final User user;
  final String token;
  final String message;

  UserResponse({
    required this.user,
    required this.token,
    required this.message,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: User.fromJson(json['data']['user']),
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
  final String jobType;
  final String job;
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
    required this.job,
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
      isPremium: json['is_premium'],
      phoneNumber: json['phone_number'],
      birthDate: json['birth_date'],
      jobType: json['job_type'],
      job: json['job'],
      gender: json['gender'],
      cityCode: json['city_code'],
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
