import 'dart:convert';

import 'package:flutter_tv_shows/data/models/user.dart';

LoginUserSuccessResponse loginUserSuccessResponseFromJson(String str) =>
    LoginUserSuccessResponse.fromJson(json.decode(str));

String loginUserSuccessResponseToJson(LoginUserSuccessResponse data) =>
    json.encode(data.toJson());

class LoginUserSuccessResponse {
  LoginUserSuccessResponse({
    this.user,
  });

  final User? user;

  factory LoginUserSuccessResponse.fromJson(Map<String, dynamic> json) =>
      LoginUserSuccessResponse(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}
