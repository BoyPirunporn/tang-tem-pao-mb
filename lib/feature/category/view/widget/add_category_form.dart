import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_select.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/viewmodel/category_viewmodel.dart';

class AddCategoryForm extends ConsumerStatefulWidget {
  final CategoryModel? data;
  const AddCategoryForm({super.key, this.data});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddCategoryFormState();
}

class _AddCategoryFormState extends ConsumerState<AddCategoryForm> {
  final _categoryNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TransactionType _selectTransactionType = TransactionType.income;
  CategoryStatus _selectCategoryStatus = CategoryStatus.active;

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      setState(() {
        _selectCategoryStatus = widget.data!.status;
        _selectTransactionType = widget.data!.type;
        _categoryNameController.text = widget.data!.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 700),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: DimensionConstant.horizontalPadding(context, 2),
          horizontal: DimensionConstant.horizontalPadding(context, 3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "เพิ่มหมวดหมู่",
              style: TextStyle(
                fontSize: DimensionConstant.responsiveFont(context, 22),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomField(
                        hintText: "เงินเดือน",
                        label: Text("ชื่อหมวดหมู่"),
                        controller: _categoryNameController,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "กรุณากรอกชื่อหมวดหมู่";
                          }
                          return null;
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 1.0,
                                  ),
                                  child: Text(value.getValue(isThai: true)),
                                ),
                              );
                            })
                            .toList(),
                        onChanged: (TransactionType? newValue) {
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
                      SizedBox(height: 20),
                      CustomSelectBox<CategoryStatus>(
                        label: "สถานะ",
                        value: _selectCategoryStatus,
                        items: CategoryStatus.values.map((
                          CategoryStatus value,
                        ) {
                          return DropdownMenuItem<CategoryStatus>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 1.0,
                              ),
                              child: Text(value.getValue(isThai: true)),
                            ),
                          );
                        }).toList(),
                        onChanged: (CategoryStatus? newValue) {
                          setState(() {
                            _selectCategoryStatus = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'กรุณาเลือกหมวดหมู่';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.data != null) {
                              return await ref
                                  .read(categoryViewModelProvider.notifier)
                                  .updateCategory(
                                    widget.data!.id,
                                    widget.data!.color,
                                    _categoryNameController.text,
                                    _selectTransactionType,
                                    _selectCategoryStatus,
                                  );
                            }
                            await ref
                                .read(categoryViewModelProvider.notifier)
                                .addCategory(
                                  _categoryNameController.text,
                                  _selectTransactionType,
                                  _selectCategoryStatus,
                                );
                          }
                        },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
