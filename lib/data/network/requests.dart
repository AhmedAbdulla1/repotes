import 'dart:io';

class LoginRequest {
  String email;
  String password;

  LoginRequest({
    required this.email,
    required this.password,
  });
}

class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String bodyWeight;
  final String height;
  final String age;
  final String gender;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.bodyWeight,
    required this.height,
    required this.age,
    required this.gender,
  });
}

class RestPasswordRequest {
  String otp;
  String password;

  RestPasswordRequest({
    required this.otp,
    required this.password,
  });
}

class UpdateProfileRequest {
  String? name = "";
  File? profilePicture;

  UpdateProfileRequest({this.name, this.profilePicture});
}
