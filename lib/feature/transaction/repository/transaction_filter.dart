// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';

part 'transaction_filter.g.dart';

@riverpod
class TransactionFilter extends _$TransactionFilter {
  @override
  TransactionFilterState build() {
    return TransactionFilterState(type: TransactionType.all, name: null);
  }

  void setFilter({TransactionType? filter, String? name}) {
    final currentState = state;
    state = currentState.copyWith(type: filter, name: name);
  }

  void reset() {
    state = TransactionFilterState(type: TransactionType.all, name: null);
  }
}

class TransactionFilterState {
  final TransactionType type;
  final String? name;
  TransactionFilterState({required this.type, this.name});

  TransactionFilterState copyWith({TransactionType? type, String? name}) {
    return TransactionFilterState(
      type: type ?? this.type,
      name: name ?? this.name,
    );
  }
}
