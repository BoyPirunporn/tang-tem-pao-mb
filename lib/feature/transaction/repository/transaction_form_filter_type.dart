import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

part 'transaction_form_filter_type.g.dart';
@riverpod
class TransactionFormFilterType extends _$TransactionFormFilterType {
  @override
  TransactionType build(){
    return TransactionType.income;
  } 

  void setFilter(TransactionType filter) {
    state = filter;
  }
}
