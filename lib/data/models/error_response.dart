import 'dart:convert';
import 'package:flutter_tv_shows/utils/utils.dart';

class ErrorResponse {
  ErrorResponse({
    this.success,
    this.errors,
  });

  final bool? success;
  final List<String>? errors;

  factory ErrorResponse.fromRawJson(String str) =>
      ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        success: json["success"],
        errors: List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "errors": errors != null
            ? List<dynamic>.from(errors!.map((x) => x))
            : '${getGlobalApplocalization()?.somethingWentWrong}',
      };
}
