import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginUserRequest extends Equatable {
  const LoginUserRequest({
    this.email,
    this.password,
  });

  final String? email;
  final String? password;

  factory LoginUserRequest.fromRawJson(String str) =>
      LoginUserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) =>
      LoginUserRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  List<Object?> get props => [email, password];
}
