import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/dimension_constant.dart';
import 'package:tang_tem_pao_mb/core/theme/app_pallete.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_appbar.dart';
import 'package:tang_tem_pao_mb/core/widgets/custom_field.dart';
import 'package:tang_tem_pao_mb/core/widgets/list_title_skeleton.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/view/widget/add_category_form.dart';
import 'package:tang_tem_pao_mb/feature/category/view/widget/category_item.dart';
import 'package:tang_tem_pao_mb/feature/category/viewmodel/category_viewmodel.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel(); // ⭐️ ยกเลิก Timer เมื่อออกจากหน้า
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(title: "หมวดหมู่"),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DimensionConstant.horizontalPadding(context, 3),
          vertical: 8,
        ),
        child: Column(
          children: [
            CustomField(
              prefixIcon: Icon(Icons.search,size: DimensionConstant.responsiveFont(context, 24),),
              hintText: "ค้นหาด้วยชื่อ",
              onChange: (String name) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  // Logic นี้จะทำงานหลังจากผู้ใช้หยุดพิมพ์ 500ms
                  // เงื่อนไข: ค้นหาเมื่อ >= 3 ตัวอักษร หรือเมื่อว่าง
                  if (name.length > 3 || name.isEmpty) {
                    ref.read(categoryFilterProvider.notifier).setValue(name);
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: ()async => ref.invalidate(categoryViewModelProvider),
                child: categoryState.when(
                  loading: () =>
                      SingleChildScrollView(child: ListTitleSkeleton(length: 10)),
                  error: (err, stack) => Center(
                    child: Text(
                      "Error: $err",
                      style: TextStyle(
                        fontSize: DimensionConstant.responsiveFont(context, 16),
                      ),
                    ),
                  ),
                  data: (state) {
                    if (state.categories.isEmpty) {
                      return Center(
                        child: Text(
                          "ยังไม่มีหมวดหมู่",
                          style: TextStyle(
                            fontSize: DimensionConstant.responsiveFont(
                              context,
                              16,
                            ),
                          ),
                        ),
                      );
                    }
                    List<CategoryModel> categories = state.categories;
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (ctx, index) {
                              final CategoryModel category = categories[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: DimensionConstant.horizontalPadding(
                                    context,
                                    1.2,
                                  ),
                                ),
                                child: CategoryItem(category: category),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "categoryPageFAB'",
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.8,
                widthFactor: 1.0,
                child: AddCategoryForm(),
              );
            },
          );
        },
        backgroundColor: AppPallete.primaryDark,
        child: Icon(Icons.add),
      ),
    );
  }
}
