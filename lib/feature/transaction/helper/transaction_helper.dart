import 'package:flutter/material.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';
import 'package:tang_tem_pao_mb/feature/transaction/view/widgets/add_transaction_form.dart';

class TransactionHelper {
  static void showBottomSheep(BuildContext context, {TransactionModel? data}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9, // เริ่มต้นสูง 90%
          minChildSize: 0.5, // ต่ำสุด 50%
          maxChildSize: 0.95, // สูงสุด 95%
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: SingleChildScrollView(
                controller: controller, // สำคัญ: ต้องใช้ controller
                child: AddTransactionForm(transaction: data),
              ),
            );
          },
        );
      },
    );
  }

  static void showDialog(
    BuildContext context, {
    TransactionModel? data,
    String? action = "สร้างธุรกรรม",
  }) {
    DialogProvider.instance.showDialogBox(
      title: action!,
      content: AddTransactionForm(transaction: data),
    );
  }
}
