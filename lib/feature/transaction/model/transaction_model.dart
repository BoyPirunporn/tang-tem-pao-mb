// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

class TransactionModel {
  String id;
  double amount;
  TransactionType type;
  String category;
  String categoryId;
  String? description;
  String transactionDate;


   TransactionModel.empty():
  id = "",
  amount = 0,
  type = TransactionType.all,
  category = "",
  categoryId = "",
  description = "",
  transactionDate = "";
  
  TransactionModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.categoryId,
    this.description,
    required this.transactionDate,
  });

 

  TransactionModel copyWith({
    String? id,
    double? amount,
    TransactionType? type,
    String? category,
    String? categoryId,
    String? description,
    String? transactionDate,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'type': type,
      'category': category,
      'categoryId': categoryId,
      'description': description,
      'transactionDate': transactionDate,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      amount: map['amount'] as double,
      type: map['type'],
      category: map['category']as String,
      categoryId: map['categoryId'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      transactionDate: map['transactionDate'] as String,
    );
  }
   factory TransactionModel.fromMapResponse(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      amount: map['amount'] as double,
      type: TransactionTypeX.fromString(map['type'] as String),
      category: map['category']as String,
      categoryId: map['categoryId'] as String,
      description: map['description'] as String,
      transactionDate: map['transactionDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(id: $id, amount: $amount, type: $type, category: $category, categoryId: $categoryId, description: $description, transactionDate: $transactionDate)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.amount == amount &&
      other.type == type &&
      other.category == category &&
      other.categoryId == categoryId &&
      other.description == description &&
      other.transactionDate == transactionDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      amount.hashCode ^
      type.hashCode ^
      category.hashCode ^
      categoryId.hashCode ^
      description.hashCode ^
      transactionDate.hashCode;
  }
}
