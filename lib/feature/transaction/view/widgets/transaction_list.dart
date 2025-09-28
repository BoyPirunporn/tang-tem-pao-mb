import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/list_title_skeleton.dart';
import 'package:tang_tem_pao_mb/feature/transaction/helper/transaction_helper.dart';
import 'package:tang_tem_pao_mb/feature/transaction/repository/transaction_filter.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/widgets/transaction_list_item.dart';
import 'package:tang_tem_pao_mb/feature/transaction/viewmodel/transaction_viewmodel.dart';

class TransactionList extends ConsumerWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionState = ref.watch(transactionViewModelProvider);
    final currentFilter = ref.watch(transactionFilterProvider);

    return Expanded(
      child: transactionState.when(
        loading: () => Padding(
          padding: EdgeInsets.symmetric(
            vertical: DimensionConstant.horizontalPadding(context, 2),
            horizontal: DimensionConstant.horizontalPadding(context, 3),
          ),
          child: ListTitleSkeleton(),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (state) => state.transactions.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ยังไม่มีข้อมูลธุระกรรม",
                      style: TextStyle(
                        fontSize: DimensionConstant.responsiveFont(context, 26),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        TransactionHelper.showBottomSheep(context);
                      },
                      child: Text(
                        "เพิ่มธุรกรรมของคุณ",
                        style: TextStyle(
                          fontSize: DimensionConstant.responsiveFont(
                            context,
                            18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: DimensionConstant.horizontalPadding(
                          context,
                          2,
                        ),
                      ),
                      itemCount: state.transactions.length,
                      itemBuilder: (ctx, index) {
                        final tx = state.transactions[index];
                        return Dismissible(
                          key: Key(tx.id),
                          confirmDismiss: (direction) async {
                            bool
                            ok = await DialogProvider.instance.showWarningDialog(
                              message:
                                  "คุณต้องการที่จะลบรายการ ${tx.category} ใช่หรือไม่",
                            );
                            return ok;
                          },
                          onDismissed: (direction) async {
                            ref
                                .read(transactionViewModelProvider.notifier)
                                .deleteTransactionById(tx.id);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${tx.category} ถูกลบแล้ว'),
                                duration: const Duration(
                                  seconds: 3,
                                ), // ควรน้อยกว่า Timer เล็กน้อย
                                action: SnackBarAction(
                                  label: 'ยกเลิก',
                                  onPressed: () {
                                    // เรียก undo โดยใช้ id
                                    ref
                                        .read(
                                          transactionViewModelProvider.notifier,
                                        )
                                        .undoDelete(tx.id);
                                  },
                                ),
                              ),
                            );
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color:
                                AppPallete.destructiveDark, // หรือ Colors.red
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          child: TransactionListItem(
                            onTap: () {
                              TransactionHelper.showBottomSheep(
                                context,
                                data: tx,
                              );
                            },
                            category: tx.category,
                            type: tx.type,
                            amount: tx.amount,
                            date: tx.transactionDate,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
