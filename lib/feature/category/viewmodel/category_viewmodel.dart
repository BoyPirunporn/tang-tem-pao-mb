import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/repository/category_repository.dart';
import 'package:tang_tem_pao_mb/feature/category/viewmodel/category_action_state_viewmodel.dart';

part 'category_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class CategoryViewModel extends _$CategoryViewModel {
  late CategoryRepository _categoryRepository;
  @override
  Future<List<CategoryModel>> build() async {
    _categoryRepository = ref.watch(categoryRepositoryProvider);

    final String? filter = ref.watch(categoryFilterProvider);
    final cancelToken = CancelToken();

    ref.onDispose(() {
      cancelToken.cancel(
        'Request was cancelled because the user navigated away.',
      );
    });
    final res = await _categoryRepository.getAllCategory(
      name: filter,
      cancelToken: cancelToken,
    );

    return res.fold(
      (l) => throw l.message, // ถ้า Error ให้ throw ออกไป
      (r) => r, // ถ้าสำเร็จ ให้คืนค่า list
    );
  }

  Future<void> addCategory(
    String name,
    TransactionType type,
    CategoryStatus status,
  ) async {
    // ⭐️ 3. บอกให้ UI รู้ว่า "กำลังเริ่มเพิ่มข้อมูลนะ"
    ref.read(categoryActionStateViewModelProvider.notifier).setLoading(true);

    try {
      final Either<AppFailure, CategoryModel> res = await _categoryRepository
          .createCategory(name, type, status);

      res.fold(
        (l) {
          // ถ้า Error, แสดง Dialog
          DialogProvider.instance.showErrorDialog(
            title: "Error",
            message: l.message,
          );
        },
        (r) {
          // ถ้าสำเร็จ, นำข้อมูลเก่ามา + ข้อมูลใหม่
          final currentCategories = state.value ?? [];
          state = AsyncValue.data([...currentCategories, r]);
          navigatorKey.currentState!.pop();
        },
      );
    } finally {
      // ⭐️ 4. ไม่ว่าจะสำเร็จหรือล้มเหลว, บอกให้ UI รู้ว่า "เพิ่มข้อมูลเสร็จแล้ว"
      ref.read(categoryActionStateViewModelProvider.notifier).setLoading(false);
    }
  }

  Future<void> updateCategory(
    String id,
    String color,
    String name,
    TransactionType type,
    CategoryStatus status,
  ) async {
    // ⭐️ 3. บอกให้ UI รู้ว่า "กำลังเริ่มเพิ่มข้อมูลนะ"
    ref.read(categoryActionStateViewModelProvider.notifier).setLoading(true);

    try {
      final Either<AppFailure, CategoryModel> res = await _categoryRepository
          .updateCategory(id, color, name, type, status);

      res.fold(
        (l) {
          // ถ้า Error, แสดง Dialog
          DialogProvider.instance.showErrorDialog(
            title: "Error",
            message: l.message,
          );
        },
        (r) {
          // ถ้าสำเร็จ, นำข้อมูลเก่ามา + ข้อมูลใหม่
          final currentCategories = state.value ?? [];
          state = AsyncValue.data([...currentCategories, r]);
          navigatorKey.currentState!.pop();
        },
      );
    } finally {
      // ⭐️ 4. ไม่ว่าจะสำเร็จหรือล้มเหลว, บอกให้ UI รู้ว่า "เพิ่มข้อมูลเสร็จแล้ว"
      ref.read(categoryActionStateViewModelProvider.notifier).setLoading(false);
    }
  }
}

@riverpod
class CategoryFilter extends _$CategoryFilter {
  @override
  String? build() {
    return null;
  }

  void setValue(String? name) {
    state = name;
  }
}
