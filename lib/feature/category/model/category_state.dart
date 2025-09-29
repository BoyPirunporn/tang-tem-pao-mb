// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';

class CategoryState {
  final List<CategoryModel> categories;
  final Map<String, CategoryTemp> temps;
  CategoryState({
    required this.categories,
     this.temps = const {},
  });
  
 

  CategoryState copyWith({
    List<CategoryModel>? categories,
    Map<String, CategoryTemp>? temps,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      temps: temps ?? this.temps,
    );
  }
}

class CategoryTemp {
  int index;
  CategoryModel category;

  CategoryTemp({required this.index, required this.category});
}
