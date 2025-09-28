import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

class CategoryUiHelper {
  /// กำหนดสีสำหรับ UI ทั่วไปตาม type
  static Color getColorForType(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return AppPallete.primaryDark;
      case TransactionType.expense:
        return AppPallete.destructiveDark;
      case TransactionType.saving:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  /// กำหนดไอคอนตาม type
  static IconData getIconForType(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return Icons.arrow_downward;
      case TransactionType.expense:
        return Icons.arrow_upward;
      case TransactionType.saving:
        return Icons.savings;
      default:
        return Icons.category;
    }
  }

  /// กำหนดสีสำหรับ CircleAvatar โดยเฉพาะ
  static Color generateColorCircle(TransactionType type) {
    switch (type) {
      case TransactionType.expense:
        return AppPallete.destructiveDark;
      case TransactionType.income:
        return AppPallete.primaryDark;
      case TransactionType.saving:
        return Colors.blueAccent;
      default:
        return AppPallete.accentDark;
    }
  }
}