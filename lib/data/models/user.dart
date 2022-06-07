import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.email,
    this.imageUrl,
  });

  final String? id;
  final String? email;
  final String? imageUrl;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "image_url": imageUrl,
      };

  @override
  List<Object?> get props => [id, email, imageUrl];
}
