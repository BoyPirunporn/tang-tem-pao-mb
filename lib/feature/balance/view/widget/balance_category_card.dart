// balance_category_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/feature/balance/model/balance_model.dart';
import 'package:tang_tem_pao_mb/feature/balance/view/widget/balance_form.dart';
import 'package:tang_tem_pao_mb/feature/balance/viewmodel/balance_viewmodel.dart';

class BalanceCategoryCard extends ConsumerWidget {
  final String title;
  final BalanceType type;
  final List<BalanceModel> items;

  const BalanceCategoryCard({
    super.key,
    required this.title,
    required this.type,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormat = NumberFormat("#,##0.00฿", "th_TH");
    final total = items.fold<double>(0, (sum, item) => sum + item.value);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: DimensionConstant.responsiveFont(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    DialogProvider.instance.showDialogBox(
                      title: "เพิ่ม $title",
                      content: BalanceForm(type: type),
                    );
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: DimensionConstant.horizontalPadding(context, 7),
                  ),
                ),
              ],
            ),
            const Divider(),
            if (items.isEmpty)
              const Expanded(child: Center(child: Text("ไม่มีรายการ")))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: DimensionConstant.responsiveFont(
                            context,
                            18,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        currencyFormat.format(item.value),
                        style: TextStyle(
                          color: item.itemType == BalanceType.asset
                              ? AppPallete.ringDark
                              : AppPallete.destructiveDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          DialogProvider.instance.showWarningDialog(
                            message: "คุณต้องการลบรายการใช่หรือไม่",
                            onOk: () async {
                              await ref
                                  .watch(balanceViewModelProvider.notifier)
                                  .deleteById(item.id);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          color: AppPallete.destructiveDark,
                        ),
                      ),
                    );
                  },
                ),
              ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "รวม",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currencyFormat.format(total),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
