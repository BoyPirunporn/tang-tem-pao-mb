import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

class TransactionTypeIcon {
  static final Map<TransactionType, dynamic> typeDetails = {
    TransactionType.income: {
      'icon': Icons.trending_down_rounded,
      'color': Colors.green,
    },
    TransactionType.expense: {
      'icon': Icons.trending_up_rounded,
      'color': Colors.red,
    },
    TransactionType.saving: {
      'icon': Icons.swap_horiz_rounded,
      'color': Colors.blue,
    },
  };

  static Map<String, dynamic> getDetails(TransactionType type) {
    return typeDetails[type] ??
        {'icon': Icons.question_mark_rounded, 'color': Colors.grey};
  }
}
