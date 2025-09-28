import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/feature/budget/model/budget_model.dart';
import 'package:tang_tem_pao_mb/feature/budget/view/widget/budget_form.dart';

class BudgetHelper {
  static void showBottomSheet(BuildContext context, String action,{BudgetModel? budget}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: Column(
              children: [
                Text(
                  "$actionเป้าหมาย",
                  style: TextStyle(
                    fontSize: DimensionConstant.responsiveFont(context, 22),
                  ),
                ),
                SizedBox(height: 20),
                BudgetForm(budgetModel:budget),
              ],
            ),
          ),
        );
      },
    );
  }
}
