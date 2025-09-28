import 'dart:developer' as logger;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/balance_model.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/balance_state.dart';
import 'package:tang_tem_pao_mb/feature/balance/repository/balance_repository.dart';

part 'balance_viewmodel.g.dart';

@Riverpod(keepAlive: false)
class BalanceViewModel extends _$BalanceViewModel {
  late BalanceRepository _balanceRepository;
  @override
  Future<BalanceState> build() async {
    _balanceRepository = ref.watch(balanceRepositoryProvider);

    final res = await _balanceRepository.getAllBalance();

    return res.fold(
      (l) {
        throw l.message;
      },
      (r) {
        List<BalanceModel> assets = r
            .where((balance) => balance.itemType == BalanceType.asset)
            .toList();
        List<BalanceModel> liabilities = r
            .where((balance) => balance.itemType == BalanceType.liability)
            .toList();

        final totalAssets = assets.fold<double>(
          0,
          (sum, item) => sum + item.value,
        );
        final totalLiabilities = liabilities.fold<double>(
          0,
          (sum, item) => sum + item.value,
        );

        return BalanceState(
          assets: assets,
          liabilities: liabilities,
          netWorth: totalAssets - totalLiabilities,
        );
      },
    );
  }

  Future<void> addBalance(String name, double amount, BalanceType type) async {
    state = AsyncValue.loading();
    final res = await _balanceRepository.addBalance(name, amount, type);
    res.fold(
      (l) {
        DialogProvider.instance.showErrorDialog(
          title: "Error",
          message: l.message,
        );
      },
      (r) {
        state = AsyncValue.data(state.value!);
        ref.invalidateSelf();
        navigatorKey.currentState!.pop();
      },
    );
  }

  Future<void> deleteById(String id) async {
    logger.log("call");
    final res = await _balanceRepository.deleteById(id);
    res.fold(
      (l) {
        DialogProvider.instance.showErrorDialog(message: l.message);
      },
      (r) async {
        bool ok = await DialogProvider.instance.showDialogBox(message: r);
        await Future.delayed(const Duration(seconds: 2));
        ref.invalidateSelf();
        if (!ok) {
          navigatorKey.currentState!.pop();
        }
      },
    );
  }
}
