// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tang_tem_pao_mb/core/enum/budget_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

class BudgetModel {
    String id;
    double targetAmount;
    TransactionType type;
    BudgetStatus status;
    double current;
    String startDate;
    String endDate;
    String categoryName;
    String categoryId;
    String createdAt;

  BudgetModel({
    required this.id,
    required this.targetAmount,
    required this.type,
    required this.status,
    required this.current,
    required this.startDate,
    required this.endDate,
    required this.categoryName,
    required this.categoryId,
    required this.createdAt,
  });

    

  BudgetModel copyWith({
    String? id,
    double? targetAmount,
    TransactionType? type,
    BudgetStatus? status,
    double? current,
    String? startDate,
    String? endDate,
    String? categoryName,
    String? categoryId,
    String? createdAt,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      targetAmount: targetAmount ?? this.targetAmount,
      type: type ?? this.type,
      status: status ?? this.status,
      current: current ?? this.current,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      categoryName: categoryName ?? this.categoryName,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'targetAmount': targetAmount,
      'type': type,
      'status': status,
      'current': current,
      'startDate': startDate,
      'endDate': endDate,
      'categoryName': categoryName,
      'categoryId': categoryId,
      'createdAt': createdAt,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'] as String,
      targetAmount: map['targetAmount'] as double,
      type: map['type'] as TransactionType,
      status: map['status'] as BudgetStatus,
      current: map['current'] as double,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      categoryName: map['categoryName'] as String,
      categoryId: map['categoryId'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
  factory BudgetModel.fromResponseMap(Map<String, dynamic> map) {
    print("id ${map['id']}");
    print("id ${map['id']}");
    print("id ${map['id']}");
    print("id ${map['id']}");
    print("id ${map['id']}");
    print("id ${map['id']}");
    print("id ${map['id']}");
    return BudgetModel(
      id: map['id'] as String,
      targetAmount: map['targetAmount'] as double,
      type: TransactionTypeX.fromString(map['type']),
      status: BudgetStatusX.formString(map['status']),
      current: map['current'] != null ? map['current'] as double : 0,
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      categoryName: map['categoryName'] != null ?map['categoryName'] as String : "",
      categoryId: map['categoryId'] as String,
      createdAt: map['createdAt'] != null ? map['createdAt']  as String : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BudgetModel.fromJson(String source) => BudgetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BudgetModel(id: $id, targetAmount: $targetAmount, type: $type, status: $status, current: $current, startDate: $startDate, endDate: $endDate, categoryName: $categoryName, categoryId: $categoryId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant BudgetModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.targetAmount == targetAmount &&
      other.type == type &&
      other.status == status &&
      other.current == current &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.categoryName == categoryName &&
      other.categoryId == categoryId &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      targetAmount.hashCode ^
      type.hashCode ^
      status.hashCode ^
      current.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      categoryName.hashCode ^
      categoryId.hashCode ^
      createdAt.hashCode;
  }
}
