import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/constant/transaction_type_icon.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

class TransactionListItem extends StatelessWidget {
  final String category;
  final TransactionType type;
  final double amount;
  final String date;
  final VoidCallback? onTap;

  const TransactionListItem({
    super.key,
    required this.category,
    required this.type,
    required this.amount,
    required this.date,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');
    
    final details = TransactionTypeIcon.getDetails(type);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: (details['color'] as Color).withValues(alpha: .1),
        child: Container(
          child: Icon(details['icon'] as IconData, color: details['color'] as Color,size: DimensionConstant.responsiveFont(context, 26),)),
      ),
      title: Text(category, style:  TextStyle(fontSize:DimensionConstant.responsiveFont(context, 16),fontWeight: FontWeight.w300)),
      subtitle: Text(date, style: TextStyle(fontSize: DimensionConstant.responsiveFont(context,14),color: Colors.grey[600])),
      trailing: Text(
        '${type == TransactionType.expense ? '-' : '+'}฿${currencyFormat.format(amount)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: type == TransactionType.expense ? AppPallete.destructiveDark : AppPallete.primaryDark,
          fontSize: DimensionConstant.responsiveFont(context,18),
        ),
      ),
      contentPadding:  EdgeInsets.symmetric(vertical: DimensionConstant.verticalPadding(context,2), horizontal: DimensionConstant.horizontalPadding(context,4)),
    );
  }
}