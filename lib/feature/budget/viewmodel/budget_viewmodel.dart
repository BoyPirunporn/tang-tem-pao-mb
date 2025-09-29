import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/budget_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/budget/model/budget_model.dart';
import 'package:tang_tem_pao_mb/feature/budget/repository/budget_repository.dart';

part 'budget_viewmodel.g.dart';

@Riverpod(keepAlive: false)
class BudgetViewModel extends _$BudgetViewModel {
  late BudgetRepository _budgetRepository;

  @override
  Future<List<BudgetModel>> build() async {
    state = AsyncValue.loading();
    _budgetRepository = ref.watch(budgetRepositoryProvider);

    final status = ref.watch(budgetFilterProvider);

    final res = await _budgetRepository.getAllWithStatusBudgets(status: status);

    return res.fold((l) => throw l.message, (r) => r);
  }

  void setStatus(BudgetStatus status) {
    ref.read(budgetFilterProvider.notifier).setStatus(status);
  }

  Future<void> createBudget({
    required String categoryId,
    required TransactionType type,
    required double targetAmount,
    required String startDate,
    required String endDate,
  }) async {
    final res = await _budgetRepository.createBudget(
      categoryId: categoryId,
      type: type,
      targetAmount: targetAmount,
      startDate: startDate,
      endDate: endDate,
    );
    return res.match(
      (l) {
        DialogProvider.instance.showErrorDialog(
          title: "เกิดข้อผิดพลาด",
          message: l.message,
        );
        state = AsyncValue.error(l.message, StackTrace.current);
      },
      (r) {
        state = AsyncData([...state.value ?? [], r]);
        Future.microtask(() {
          navigatorKey.currentState!.pop();
        });
      },
    );
  }

  Future<void> editBudget({
    required String id,
    required String categoryId,
    required TransactionType type,
    required double targetAmount,
    required String startDate,
    required String endDate,
    BudgetStatus? status
  }) async {
    final res = await _budgetRepository.editBudget(
      id:id,
      categoryId: categoryId,
      type: type,
      targetAmount: targetAmount,
      startDate: startDate,
      endDate: endDate,
      status: status
    );
    return res.match(
      (l) {
        DialogProvider.instance.showErrorDialog(
          title: "เกิดข้อผิดพลาด",
          message: l.message,
        );
      },
      (r) {
        state = AsyncData([...state.value!.filter((e) => e.id != id), r]);
      },
    );
  }

  Future<void> deleteBudget(String id) async {
    final res = await _budgetRepository.deleteById(id);
    return res.match(
      (l) {
        DialogProvider.instance.showErrorDialog(
          title: "เกิดข้อผิดพลาด",
          message: l.message,
        );
      },
      (r) {
        final currentState = state.value ?? [];
        state = AsyncData(currentState.filter((c) => c.id != id).toList());
      },
    );
  }
}

@riverpod
class BudgetFilter extends _$BudgetFilter {
  @override
  BudgetStatus build() {
    return BudgetStatus.active;
  }

  void setStatus(BudgetStatus newStatus) {
    state = newStatus;
  }
}
