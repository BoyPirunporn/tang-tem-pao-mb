// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';

class BalanceModel {
  String id;
  String name;
  BalanceType itemType;
  double value;
  BalanceModel({
    required this.id,
    required this.name,
    required this.itemType,
    required this.value,
  });

  BalanceModel copyWith({
    String? id,
    String? name,
    BalanceType? itemType,
    double? value,
  }) {
    return BalanceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      itemType: itemType ?? this.itemType,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'itemType': itemType,
      'value': value,
    };
  }

  factory BalanceModel.fromMap(Map<String, dynamic> map) {
    return BalanceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      itemType: map['itemType'],
      value: map['value'] as double,
    );
  }
  factory BalanceModel.fromResponseMap(Map<String, dynamic> map) {
    return BalanceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      itemType: BalanceTypeX.formString(map['itemType']),
      value: map['value'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory BalanceModel.fromJson(String source) => BalanceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BalanceModel(id: $id, name: $name, itemType: $itemType, value: $value)';
  }

  @override
  bool operator ==(covariant BalanceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.itemType == itemType &&
      other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      itemType.hashCode ^
      value.hashCode;
  }
}
