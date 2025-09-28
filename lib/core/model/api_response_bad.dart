import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiResponseBad {
  String message;
  int status;
  Map<String, dynamic> errors;
  ApiResponseBad({
    required this.message,
    required this.status,
    required this.errors,
  });

  ApiResponseBad copyWith({
    String? message,
    int? status,
    Map<String, dynamic>? errors,
  }) {
    return ApiResponseBad(
      message: message ?? this.message,
      status: status ?? this.status,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'errors': errors,
    };
  }

  factory ApiResponseBad.fromMap(Map<String, dynamic> map) {
    return ApiResponseBad(
      message: map['message'] as String,
      status: map['status'] as int,
      errors: Map<String, dynamic>.from(
        (map['errors'] as Map<String, dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponseBad.fromJson(String source) =>
      ApiResponseBad.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ApiResponseBad(message: $message, status: $status, errors: $errors)';

  @override
  bool operator ==(covariant ApiResponseBad other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.status == status &&
        mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode ^ errors.hashCode;
}
