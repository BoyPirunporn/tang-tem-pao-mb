import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/repository/category_repository.dart';
import 'package:tang_tem_pao_mb/feature/transaction/repository/transaction_form_filter_type.dart';

part 'category_filter_type_viewmodel.g.dart';

@riverpod
class CategoryFilterTypeViewModel extends _$CategoryFilterTypeViewModel {
  late CategoryRepository _categoryRepository;
  @override
  Future<List<CategoryModel>> build() async {
    state = AsyncValue.loading();
    _categoryRepository = ref.watch(categoryRepositoryProvider);
    final type = ref.watch(transactionFormFilterTypeProvider);
    // เมธอดนี้จะถูกเรียกแค่ครั้งเดียวตอน Provider ถูกสร้าง
    final res = await _categoryRepository.getAllCategory(type: type);

    return res.fold(
      (l){
        DialogProvider.instance.showErrorDialog(message: l.message);
        state = AsyncValue.error(l.message, StackTrace.current);
        return const [];
      }, // ถ้า Error ให้ throw ออกไป
      (r){
        return r;
      }, // ถ้าสำเร็จ ให้คืนค่า list
    );
  }
}