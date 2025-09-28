import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/view/widget/add_category_form.dart';
import 'package:tang_tem_pao_mb/feature/category/view/widget/category_ui_helper.dart';

class CategoryItem extends ConsumerWidget {
  final CategoryModel category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardBorderRadius = BorderRadius.circular(12.0);
    final borderColor = CategoryUiHelper.getColorForType(category.type);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      // ⭐️ 2. (สำคัญ) ย้อมสีเงาให้เป็นโทนเดียวกับเส้นขอบ
      shadowColor: borderColor.withAlpha(150),

      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor, width: .8),
        borderRadius: cardBorderRadius,
      ),
      child: InkWell(
        child: ListTile(
          onTap: () {
            DialogProvider.instance.showDialogBox(title: "แก้ไข",content: AddCategoryForm(data: category,));
          },
          leading: CircleAvatar(
            backgroundColor:CategoryUiHelper.generateColorCircle(
              category.type,
            ), // ใช้สีที่มากับ category
            child: Icon(CategoryUiHelper.getIconForType(category.type), color: Colors.white),
          ),
          title: Text(
            category.name,
            style:  TextStyle(fontWeight: FontWeight.w600, fontSize: DimensionConstant.responsiveFont(context, 16)),
          ),
          subtitle: Text(
            category.status.getValue(isThai: true), // active / inactive
            style: TextStyle(color: Colors.grey[600], fontSize:  DimensionConstant.responsiveFont(context, 16)),
          ),
          trailing: Container(
            padding:  EdgeInsets.symmetric(horizontal: DimensionConstant.horizontalPadding(context,2), vertical: DimensionConstant.horizontalPadding(context,1)),
            decoration: BoxDecoration(
              color: borderColor.withValues(alpha:0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category.type.getValue(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: borderColor,
                fontSize: DimensionConstant.responsiveFont(context, 14)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
