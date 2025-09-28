// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenResponseModel {
  String token;
  String refreshToken;
  String name;
  int expires;

  TokenResponseModel({
    required this.token,
    required this.refreshToken,
    required this.name,
    required this.expires,
  });

  TokenResponseModel copyWith({
    String? token,
    String? refreshToken,
    String? name,
    int? expires,
  }) {
    return TokenResponseModel(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      name: name ?? this.name,
      expires: expires ?? this.expires,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'refreshToken': refreshToken,
      'name': name,
      'expires': expires,
    };
  }

  factory TokenResponseModel.fromMap(Map<String, dynamic> map) {
    int expiresMillis;

    if (map['expires'] is String) {
      // ถ้าเป็น String ให้แปลงเป็น DateTime ก่อน
      final expiresStr = map['expires'] as String;
      final expiresDateTime = DateTime.parse(expiresStr.replaceFirst(' ', 'T'));
      expiresMillis = expiresDateTime.millisecondsSinceEpoch;
    } else if (map['expires'] is int) {
      // ถ้าเป็น int อยู่แล้ว
      expiresMillis = map['expires'] as int;
    } else {
      // fallback
      expiresMillis = 0;
    }

    return TokenResponseModel(
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
      name: map['name'] as String,
      expires: expiresMillis,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenResponseModel.fromJson(String source) =>
      TokenResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokenResponseModel(token: $token, refreshToken: $refreshToken, name: $name, expires: $expires)';
  }

  @override
  bool operator ==(covariant TokenResponseModel other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.refreshToken == refreshToken &&
        other.name == name &&
        other.expires == expires;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        refreshToken.hashCode ^
        name.hashCode ^
        expires.hashCode;
  }

  bool get isExpired {
    final now = DateTime.now().millisecondsSinceEpoch;
    // ลบ margin ซัก 60 วิ กันตกรถ
    
    return now >= (expires - 60000);
  }
}
