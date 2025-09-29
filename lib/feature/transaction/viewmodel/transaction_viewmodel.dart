import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_state.dart';
import 'package:tang_tem_pao_mb/feature/transaction/repository/transaction_filter.dart';
import 'package:tang_tem_pao_mb/feature/transaction/repository/transaction_repository.dart';

part 'transaction_viewmodel.g.dart';

@Riverpod(keepAlive: false)
class TransactionViewModel extends _$TransactionViewModel {
  late TransactionRepository _transactionRepository;
  final Map<String, Timer> _deleteTimers = {};

  @override
  Future<TransactionState> build() async {
    state = AsyncValue.loading();
    _transactionRepository = ref.watch(transactionRepositoryProvider);
    final filter = ref.watch(transactionFilterProvider);
    final cancelToken = CancelToken();

    ref.onDispose(() {
      cancelToken.cancel(
        'Request was cancelled because the user navigated away.',
      );
    });

    final res = await _transactionRepository.getAllTransaction(
      type: filter.type,
      name: filter.name,
      cancelToken: cancelToken,
    );

    return res.fold((l){
      state = AsyncValue.error(l.message, StackTrace.current);
      return TransactionState(transactions: const []);
    }, (r) {
      return TransactionState(transactions: r, temps: {});
    });
  }

  Future<void> createTransaction(
    double amount,
    TransactionType type,
    String transactionDate,
    String description,
    String categoryId,
  ) async {
    state = AsyncValue.loading();
    final res = await _transactionRepository.createTransaction(
      type: type,
      transactionDate: transactionDate,
      description: description,
      categoryId: categoryId,
      amount: amount,
    );
    return res.match(
      (l) {
        throw l.message;
      },
      (r) {
        final currentState = state.value;
        if (currentState != null) {
          currentState.transactions.add(r);
          state = AsyncValue.data(currentState);
        }
      },
    );
  }
  Future<void> updateTransaction(
    String id,
    double amount,
    TransactionType type,
    String transactionDate,
    String description,
    String categoryId,
  ) async {
    state = AsyncValue.loading();
    final res = await _transactionRepository.updateTransaction(
      id:id,
      type: type,
      transactionDate: transactionDate,
      description: description,
      categoryId: categoryId,
      amount: amount,
    );
    return res.match(
      (l) {
        DialogProvider.instance.showErrorDialog(message: l.message);
        state = AsyncValue.error(l.message, StackTrace.current);
      },
      (r) {
        final currentState = state.value;
        if (currentState != null) {
          currentState.transactions.add(r);
          state = AsyncValue.data(currentState);
        }
      },
    );
  }

  void deleteTransactionById(String id) {
    final currentState = state.value;
    if (currentState == null) return;

    final transactionToRemove = currentState.transactions.firstWhere(
      (tx) => tx.id == id,
    );

    final index = currentState.transactions.indexOf(transactionToRemove);
    final tempItem = TransactionTemp(
      index: index,
      transaction: transactionToRemove,
    );

    // 1. อัปเดต UI ทันที (Immutable update)
    final newTransactions = currentState.transactions
        .where((tx) => tx.id != id)
        .toList();
    final newTemps = {...currentState.temps, id: tempItem};

    state = AsyncValue.data(
      currentState.copyWith(transactions: newTransactions, temps: newTemps),
    );

    // 2. ยกเลิก Timer เก่า (ถ้ามี) และสตาร์ท Timer ใหม่เพื่อลบจริง
    _deleteTimers[id]?.cancel();
    _deleteTimers[id] = Timer(const Duration(seconds: 4), () {
      // หน่วงเวลา 4 วินาที
      _finalizeDelete(id);
    });
  }

  void undoDelete(String id) {
    // 1. ยกเลิก Timer ก่อนที่มันจะลบจริง
    _deleteTimers[id]?.cancel();
    _deleteTimers.remove(id);

    final currentState = state.value;
    final tempItem = currentState?.temps[id];

    if (currentState == null || tempItem == null) return;

    // 2. นำ item กลับเข้าที่เดิม (Immutable update)
    final newTransactions = [...currentState.transactions];
    newTransactions.insert(tempItem.index, tempItem.transaction);

    final newTemps = {...currentState.temps}..remove(id);

    state = AsyncValue.data(
      currentState.copyWith(transactions: newTransactions, temps: newTemps),
    );
  }

  Future<void> _finalizeDelete(String id) async {
    print('Finalizing delete for $id');
    // 1. เรียก API เพื่อลบข้อมูลจาก Backend
    await _transactionRepository.deleteById(id);

    // 2. เคลียร์ item ออกจาก temps ใน State
    final currentState = state.value;
    if (currentState != null) {
      final newTemps = {...currentState.temps}..remove(id);
      state = AsyncValue.data(currentState.copyWith(temps: newTemps));
    }

    _deleteTimers.remove(id);
  }
}
