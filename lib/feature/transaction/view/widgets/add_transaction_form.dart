import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/constant/transaction_type_icon.dart';
import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_select.dart';
import 'package:tang_tem_pao_mb/core/widgets/datepicker_field.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/viewmodel/category_filter_type_viewmodel.dart';
import 'package:tang_tem_pao_mb/feature/transaction/model/transaction_model.dart';
import 'package:tang_tem_pao_mb/feature/transaction/repository/transaction_form_filter_type.dart';
import 'package:tang_tem_pao_mb/feature/transaction/viewmodel/transaction_viewmodel.dart';

// This widget is now designed to be the CONTENT of a dialog, not a full screen.
class AddTransactionForm extends ConsumerStatefulWidget {
  final TransactionModel? transaction;
  const AddTransactionForm({super.key, this.transaction});

  @override
  ConsumerState<AddTransactionForm> createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends ConsumerState<AddTransactionForm> {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  TransactionModel? get transactionData => widget.transaction;
  // State variables for the form
  String _amountString = '0';
  String? _selectedCategory;
  final _descriptionController = TextEditingController();
  final _transactionDate = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (transactionData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(transactionFormFilterTypeProvider.notifier)
            .setFilter(transactionData!.type);
      });
      _amountString = transactionData!.amount.toStringAsFixed(0);
      _selectedCategory = transactionData!.categoryId;
      _transactionDate.text = transactionData!.transactionDate;
      if (transactionData!.description != null) {
        _descriptionController.text = transactionData!.description as String;
      }
    } else {
      _transactionDate.text = dateFormat.format(DateTime.now());
    }
  }

  // --- Keypad Logic ---
  void _onKeyPressed(String value) {
    setState(() {
      if (value == '-') {
        // Backspace
        _amountString = _amountString.length > 1
            ? _amountString.substring(0, _amountString.length - 1)
            : '0';
      } else if (value == '.' && _amountString.contains('.')) {
        // Do nothing if decimal point already exists
        return;
      } else {
        if (_amountString == '0' && value != '.') {
          _amountString = value;
        } else {
          // Limit to 2 decimal places
          if (_amountString.contains('.') &&
              _amountString.split('.')[1].length >= 2) {
            return;
          }
          _amountString += value;
        }
      }
    });
  }

  void _onSave() async {
    try {
      if (_formKey.currentState!.validate()) {
        final selectedType = ref.read(transactionFormFilterTypeProvider);
        if (transactionData != null) {
          await ref
              .watch(transactionViewModelProvider.notifier)
              .updateTransaction(
                transactionData!.id,
                double.parse(_amountString),
                selectedType,
                _transactionDate.text,
                _descriptionController.text,
                _selectedCategory!,
              );
        } else {
          await ref
              .watch(transactionViewModelProvider.notifier)
              .createTransaction(
                double.parse(_amountString),
                selectedType,
                _transactionDate.text,
                _descriptionController.text,
                _selectedCategory!,
              );
        }

        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      DialogProvider.instance.showDialogBox(
        message: e.toString(),
        title: "Error",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'th_TH', symbol: '฿');
    double currentAmount = double.tryParse(_amountString) ?? 0.0;
    final selectedType = ref.watch(transactionFormFilterTypeProvider);
    final isLoading = ref.watch(
      categoryFilterTypeViewModelProvider.select((state) => state.isLoading),
    );
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: DimensionConstant.verticalPadding(context, 2),
              horizontal: DimensionConstant.verticalPadding(context, 5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                _buildTypeSelector(),
                const SizedBox(height: 24),
                Text(
                  currencyFormat.format(currentAmount),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: selectedType == TransactionType.income
                        ? Colors.green
                        : (selectedType == TransactionType.expense
                              ? Colors.red
                              : Colors.blue),
                  ),
                ),
                const SizedBox(height: 24),

                // --- Detail Fields (Category, Description) ---
                _buildDetailFields(),
                const SizedBox(height: 24),

                // // --- Numeric Keypad ---
                _buildNumericKeypad(),
                // --- Action Buttons ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // ทำให้ปุ่มชิดขอบ
                        minimumSize: Size(0, 0), // ปรับขนาดให้เล็กที่สุด
                        tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap, // ลดพื้นที่คลิก
                      ),
                      child: Text(
                        "ยกเลิก",
                        style: TextStyle(
                          fontSize: DimensionConstant.responsiveFont(
                            context,
                            16,
                          ),
                          color: AppPallete.destructiveDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: isLoading ? null : _onSave,
                      child: Text(
                        "บันทึก",
                        style: TextStyle(
                          fontSize: DimensionConstant.responsiveFont(
                            context,
                            16,
                          ),
                          color: AppPallete.ringDark,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
        if (isLoading)
          Positioned(
            width: DimensionConstant.screenWidth(context),
            height: DimensionConstant.screenHeight(context),
            child: Container(
              decoration: BoxDecoration(
                color: AppPallete.accentDark.withValues(alpha: 0.5),
              ),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }

  // --- Helper Widgets (mostly unchanged) ---

  Widget _buildTypeSelector() {
    final selectedType = ref.watch(transactionFormFilterTypeProvider);
    return ToggleButtons(
      isSelected: [
        selectedType == TransactionType.income,
        selectedType == TransactionType.expense,
        selectedType == TransactionType.saving,
      ],
      onPressed: (index) {
        if (widget.transaction != null) return;
        // ⭐️ 3. เมื่อกด, ให้อัปเดต State ใน Provider
        //    (และรีเซ็ต Category ที่เคยเลือกไว้)
        setState(() {
          _selectedCategory = null;
          _formKey.currentState!.reset();
        });
        TransactionType newType;
        if (index == 0) {
          newType = TransactionType.income;
        } else if (index == 1) {
          newType = TransactionType.expense;
        } else {
          newType = TransactionType.saving;
        }
        ref.read(transactionFormFilterTypeProvider.notifier).setFilter(newType);
      },
      borderRadius: BorderRadius.circular(8),
      selectedColor: Colors.white,
      fillColor: selectedType == TransactionType.income
          ? Colors.green
          : (selectedType == TransactionType.expense
                ? Colors.red
                : Colors.blue),
      color: Colors.grey[600],
      constraints: BoxConstraints(
        minHeight: 40,
        // minWidth: (MediaQuery.of(context).size.width * 0.7) / 3,
        minWidth: DimensionConstant.horizontalPadding(context, 10),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            TransactionType.income.getValue(isThai: true),
            style: TextStyle(
              fontSize: DimensionConstant.responsiveFont(context, 16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            TransactionType.expense.getValue(isThai: true),
            style: TextStyle(
              fontSize: DimensionConstant.responsiveFont(context, 16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            TransactionType.saving.getValue(isThai: true),
            style: TextStyle(
              fontSize: DimensionConstant.responsiveFont(context, 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailFields() {
    final categoryListAsync = ref.watch(categoryFilterTypeViewModelProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          DatePickerField(
            controller: _transactionDate,
            lastDate: DateTime.now(),
          ),
          const SizedBox(height: 16),
          CustomSelectBox<String>(
            label: "หมวดหมู่",
            hint: "เลือกหมวดหมู่",
            value: _selectedCategory,
            readOnly: categoryListAsync.isLoading,
            items: categoryListAsync.when(
              loading: () => [],
              error: (error, stack) => [],
              data: (categories) {
                return categories.where((c) => c.status != CategoryStatus.inactive).map((CategoryModel category) {
                  final detail = TransactionTypeIcon.getDetails(category.type);
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: (detail['color'] as Color)
                                .withValues(alpha: .1),
                            child: Icon(
                              detail['icon'] as IconData,
                              color: detail['color'] as Color,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(category.name),
                        ],
                      ),
                    ),
                  );
                }).toList();
              },
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCategory = newValue;
                });
              }
            },
            validator: (value) {
              if (value == null) {
                return 'กรุณาเลือกหมวดหมู่';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),
          CustomField(
            controller: _descriptionController,
            contentPadding: EdgeInsets.symmetric(
              vertical: DimensionConstant.verticalPadding(context, 8),
              horizontal: DimensionConstant.verticalPadding(context, 2),
            ),
            hintText: 'คำอธิบาย (ไม่บังคับ)',
            prefixIcon: Icon(
              Icons.description_rounded,
              color: AppPallete.ringDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericKeypad() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0', '-'];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2 / 1.2,
      children: List.generate(keys.length, (index) {
        final key = keys[index];
        if (index == keys.length - 1) {
          return InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => _onKeyPressed(key),
            child: const Center(
              child: Icon(Icons.backspace_outlined, size: 28),
            ),
          );
        }
        return InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () => _onKeyPressed(key),
          child: Center(
            child: Text(
              key,
              style: TextStyle(
                fontSize: DimensionConstant.responsiveFont(context, 20),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
