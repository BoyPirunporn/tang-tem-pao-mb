// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';
class TransactionTemp {
  int index;
  TransactionModel transaction;
  TransactionTemp({
    required this.index,
    required this.transaction
  });
}

class TransactionState {
  final List<TransactionModel> transactions;
  // ⭐️ เปลี่ยนเป็น Map เพื่อประสิทธิภาพที่ดีกว่า
  final Map<String, TransactionTemp> temps;

  TransactionState({
    required this.transactions,
    this.temps = const {}, // ค่าเริ่มต้นเป็น Map ว่าง
  });

  TransactionState copyWith({
    List<TransactionModel>? transactions,
    Map<String, TransactionTemp>? temps,
  }) {
    return TransactionState(
      transactions: transactions ?? this.transactions,
      temps: temps ?? this.temps,
    );
  }
}