import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiResponse {
  String message;
  int status;
  DateTime? timestamp;

  ApiResponse({
    required this.message,
    required this.status,
    required this.timestamp,
  });
  

  ApiResponse copyWith({
    String? message,
    int? status,
    DateTime? timestamp,
  }) {
    return ApiResponse(
      message: message ?? this.message,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'timestamp': timestamp?.toIso8601String(),
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      message: map['message'] as String,
      status: map['status'] as int,
      timestamp: map['timestamp'] != null
        ? DateTime.tryParse(map['timestamp'].toString())
        : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) => ApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiResponse(message: $message, status: $status, timestamp: $timestamp)';

  @override
  bool operator ==(covariant ApiResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.message == message &&
      other.status == status &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode => message.hashCode ^ status.hashCode ^ timestamp.hashCode;
}
