import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/balance_type_enum.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_button.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/feature/balance/viewmodel/balance_viewmodel.dart';

class BalanceForm extends ConsumerStatefulWidget {
  final BalanceType type;
  const BalanceForm({super.key, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BalanceFormState();
}

class _BalanceFormState extends ConsumerState<BalanceForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomField(
            controller: _nameController,
            label: Text("รายการ"),
            validator: (validate) {
              if (validate == null || validate.isEmpty || validate == "") {
                return "กรุณากรอกข้อมูลรายการ";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomField(
            controller: _amountController,
            label: Text("จำนวน"),
            validator: (validate) {
              if (validate == null || validate.isEmpty || validate == "") {
                return "กรุณากรอกจำนวน";
              }
              final numeric = RegExp(r'^\d+(\.\d+)?$');
              if (!numeric.hasMatch(validate)) {
                return "กรุณากรอกข้อมูลเป็นตัวเลข";
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: DimensionConstant.height(context,5),
                constraints: BoxConstraints(maxWidth: 100, maxHeight: 80),
                child: Button(
                  color: AppPallete.destructiveDark,
                  buttonText: "ยกเลิก",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 10),

              Container(
                height: DimensionConstant.height(context,5),
                constraints: BoxConstraints(maxWidth: 100, maxHeight: 80),
                child: Button(
                  buttonText: "บันทึก",
                  isSubmitting: ref.read(balanceViewModelProvider).isLoading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(balanceViewModelProvider.notifier)
                          .addBalance(
                            _nameController.text,
                            double.parse(_amountController.text),
                            widget.type,
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
