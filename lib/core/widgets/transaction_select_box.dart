import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_select.dart';

class TransactionSelectBox extends ConsumerWidget {
  TransactionType? selectTransactionType;
  void Function(TransactionType?) onChange;
  String? Function(TransactionType?)? validator;
  String? hintText;
  TransactionSelectBox({
    super.key,
    this.selectTransactionType,
    required this.onChange,
    this.validator,
    this.hintText
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomSelectBox<TransactionType>(
      label: "ประเภท",
      hint: hintText,
      value: selectTransactionType,
      items: TransactionType.values
          .where((type) => type != TransactionType.all)
          .toList()
          .map((TransactionType value) {
            return DropdownMenuItem<TransactionType>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Text(value.getValue(isThai: true)),
              ),
            );
          })
          .toList(),
      onChanged: onChange,
      validator: validator,
    );
  }
}
