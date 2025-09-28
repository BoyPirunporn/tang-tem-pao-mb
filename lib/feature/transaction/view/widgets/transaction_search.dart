import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_select.dart';
import 'package:tang_tem_pao_mb/feature/transaction/repository/transaction_filter.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/widgets/transaction_list.dart';

class TransactionSearch extends ConsumerStatefulWidget {
  const TransactionSearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionSearchState();
}

class _TransactionSearchState extends ConsumerState<TransactionSearch> {
  TransactionType? type;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel(); // ⭐️ ยกเลิก Timer เมื่อออกจากหน้า
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (pop,_) {
        print("pop $pop");
        if(pop){
          print("ispop $pop");
          ref.read(transactionFilterProvider.notifier).reset();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "ค้นหารายการธุรกรรม"),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: DimensionConstant.horizontalPadding(context, 3),
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomSelectBox<TransactionType>(
                      label: "ประเภท",
                      hint: "ประเภทธุรกรรม",
                      value: type,
                      items: TransactionType.values.toList().map((
                        TransactionType value,
                      ) {
                        return DropdownMenuItem<TransactionType>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 1.0,
                            ),
                            child: Text(value.getValue(isThai: true)),
                          ),
                        );
                      }).toList(),
                      onChanged: (TransactionType? type) {
                        ref
                            .read(transactionFilterProvider.notifier)
                            .setFilter(filter: type);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomField(
                      hintText: "ค้นหาด้วยชื่อรายการ",
                      prefixIcon: Icon(Icons.search),
                      onChange: (String name) {
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                          () {
                            // Logic นี้จะทำงานหลังจากผู้ใช้หยุดพิมพ์ 500ms
                            // เงื่อนไข: ค้นหาเมื่อ >= 3 ตัวอักษร หรือเมื่อว่าง
                            if (name.length > 3 || name.isEmpty) {
                              ref
                                  .read(transactionFilterProvider.notifier)
                                  .setFilter(name: name);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TransactionList(),
            ],
          ),
        ),
      ),
    );
  }
}
