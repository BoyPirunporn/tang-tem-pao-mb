import 'dart:convert';

import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DashboardRecentTransactionModel {
  String id;
  String categoryId;
  String category;
  double amount;
  TransactionType type;
  String description;
  String transactionDate;
  DashboardRecentTransactionModel({
    required this.id,
    required this.categoryId,
    required this.category,
    required this.amount,
    required this.type,
    required this.description,
    required this.transactionDate,
  });

  DashboardRecentTransactionModel copyWith({
    String? id,
    String? categoryId,
    String? category,
    double? amount,
    TransactionType? type,
    String? description,
    String? transactionDate,
  }) {
    return DashboardRecentTransactionModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'category': category,
      'amount': amount,
      'type': type,
      'description': description,
      'transactionDate': transactionDate,
    };
  }

  factory DashboardRecentTransactionModel.fromMap(Map<String, dynamic> map) {
    return DashboardRecentTransactionModel(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      category: map['category'] as String,
      amount: map['amount'] as double,
      type: map['type'],
      description: map['description'] as String,
      transactionDate: map['transactionDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardRecentTransactionModel.fromJson(String source) => DashboardRecentTransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardRecentTransactionModel(id: $id, categoryId: $categoryId, category: $category, amount: $amount, type: $type, description: $description, transactionDate: $transactionDate)';
  }

  @override
  bool operator ==(covariant DashboardRecentTransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.categoryId == categoryId &&
      other.category == category &&
      other.amount == amount &&
      other.type == type &&
      other.description == description &&
      other.transactionDate == transactionDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      categoryId.hashCode ^
      category.hashCode ^
      amount.hashCode ^
      type.hashCode ^
      description.hashCode ^
      transactionDate.hashCode;
  }
}
