import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppPallete.shadow,
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: DimensionConstant.horizontalPadding(context, 4),
            horizontal: DimensionConstant.horizontalPadding(context, 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: DimensionConstant.responsiveFont(context, 22),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: DimensionConstant.responsiveFont(context, 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                amount,
                style: TextStyle(
                  fontSize: DimensionConstant.responsiveFont(context, 22),
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
