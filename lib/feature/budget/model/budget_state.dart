// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tang_tem_pao_mb/core/enum/budget_status_enum.dart';
import 'package:tang_tem_pao_mb/feature/budget/model/budget_model.dart';

class BudgetState {
  BudgetStatus status;
  List<BudgetModel> budgets;

  BudgetState({
    this.status = BudgetStatus.active,
    List<BudgetModel>? budgets,
  }) : budgets = budgets ?? List<BudgetModel>.empty(growable: true);
}

