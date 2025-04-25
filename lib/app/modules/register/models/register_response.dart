import 'package:ebookapp/app/data/models/user_model.dart';

class RegisterResponse {
  RegisterResponseData data;
  String message;

  RegisterResponse({required this.data, required this.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      data: RegisterResponseData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class RegisterResponseData {
  User user;
  String token;

  RegisterResponseData({required this.user, required this.token});

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) {
    return RegisterResponseData(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}
