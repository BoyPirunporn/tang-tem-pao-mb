import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_button.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_select.dart';
import 'package:tang_tem_pao_mb/core/widgets/datepicker_field.dart';
import 'package:tang_tem_pao_mb/feature/budget/model/budget_model.dart';
import 'package:tang_tem_pao_mb/feature/budget/viewmodel/budget_viewmodel.dart';
import 'package:tang_tem_pao_mb/feature/category/viewmodel/category_viewmodel.dart';

class BudgetForm extends ConsumerStatefulWidget {
  final BudgetModel? budgetModel;
  const BudgetForm({super.key, this.budgetModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BudgetFormState();
}

class _BudgetFormState extends ConsumerState<BudgetForm> {
  final _formKey = GlobalKey<FormState>();
  final _targetAmountController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  TransactionType? _selectTransactionType;
  String? _categoryId;

  @override
  void dispose() {
    _targetAmountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final budget = widget.budgetModel;
    if (budget != null) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(categoryViewModelProvider.notifier);
      });
      setState(() {
        _targetAmountController.text = budget.targetAmount.toString();
        _startDateController.text = budget.startDate;
        _endDateController.text = budget.endDate;
        _selectTransactionType = budget.type;
        _categoryId = budget.categoryId;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryViewModelProvider);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: EdgeInsets.all(
          DimensionConstant.horizontalPadding(context, 4),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              categoryState.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                data: (data) {
                  return CustomSelectBox<String>(
                    label: "หมวดหมู่",
                    hint: "กรุณาเลือกหมวดหมู่",
                    value: _categoryId,
                    items: data.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Text(category.name),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? v) {
                      if (!mounted) return;
                      setState(() {
                        _categoryId = v;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'กรุณาเลือกหใวดหมู่';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomSelectBox<TransactionType>(
                label: "ประเภท",
                hint: "กรุณาเลือกประเภท",
                value: _selectTransactionType,
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
                onChanged: (TransactionType? newValue) {
                  if (!mounted) return;
                  setState(() {
                    _selectTransactionType = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'กรุณาเลือกประเภท';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomField(
                controller: _targetAmountController,
                label: Text("เป้าหมาย"),
                validator: (value) {
                  if (value == null) {
                    return 'กรุณากรอกเป้าหมาย';
                  }
                  final numeric = RegExp(r'^\d+(\.\d+)?$');
                  if (!numeric.hasMatch(value)) {
                    return "กรุณากรอกเป็นตัวเลข";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DatePickerField(
                controller: _startDateController,
                label: Text("วันที่ต้องการเริ่ม"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาเลือกวันที่ต้องการเริ่ม';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              DatePickerField(
                controller: _endDateController,
                label: Text("วันที่ต้องการสิ้นสุด"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาเลือกวันที่ต้องการสิ้นสุด';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Button(
                buttonText: "บันทึก",
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if(widget.budgetModel != null){
                      return await ref
                        .read(budgetViewModelProvider.notifier)
                        .editBudget(
                          id:widget.budgetModel!.id,
                          categoryId: _categoryId!,
                          type: _selectTransactionType!,
                          targetAmount: double.parse(
                            _targetAmountController.text,
                          ),
                          startDate: _startDateController.text,
                          endDate: _endDateController.text,
                        );
                    }
                    await ref
                        .read(budgetViewModelProvider.notifier)
                        .createBudget(
                          categoryId: _categoryId!,
                          type: _selectTransactionType!,
                          targetAmount: double.parse(
                            _targetAmountController.text,
                          ),
                          startDate: _startDateController.text,
                          endDate: _endDateController.text,
                        );
                    
                  }
                },
              ),
              const SizedBox(height: 15),
              Button(
                buttonText: "ยกเลิก",
                onTap: () {
                  Navigator.pop(context);
                },
                color: AppPallete.destructiveDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
