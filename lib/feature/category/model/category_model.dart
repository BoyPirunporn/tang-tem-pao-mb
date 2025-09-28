// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

class CategoryModel {
  String id;
  String name;
  TransactionType type;
  CategoryStatus status;
  String color;

  CategoryModel.empty()
    : id = "",
      name = "",
      type = TransactionType.all,
      status = CategoryStatus.active,
      color = "";

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.color,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    TransactionType? type,
    CategoryStatus? status,
    String? color,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'color': color,
    };
  }

  factory CategoryModel.fromMapResponse(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      type: TransactionTypeX.fromString(map['type'] as String),
      status: CategoryStatusX.fromString(map['status'] as String),
      color: map['color'] as String,
    );
  }
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      type: map['type'],
      status: map['status'],
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, type: $type, status: $status, color: $color)';
  }

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.status == status &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        status.hashCode ^
        color.hashCode;
  }
}
