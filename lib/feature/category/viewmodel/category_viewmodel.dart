import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_state.dart';
import 'package:tang_tem_pao_mb/feature/category/repository/category_repository.dart';
import 'package:tang_tem_pao_mb/feature/category/viewmodel/category_action_state_viewmodel.dart';

part 'category_viewmodel.g.dart';

@Riverpod(keepAlive: false)
class CategoryViewModel extends _$CategoryViewModel {
  late CategoryRepository _categoryRepository;
  final Map<String, Timer> _deleteTimers = {};

  @override
  Future<CategoryState> build() async {
    state = AsyncValue.loading();
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
      (r) => CategoryState(categories: r), // ถ้าสำเร็จ ให้คืนค่า list
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
          final currentCategories = state.value;
          if (currentCategories == null) {
            return;
          }
          state = AsyncValue.data(
            currentCategories.copyWith(
              categories: [...currentCategories.categories, r],
            ),
          );
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
          final currentCategories = state.value;
          if (currentCategories == null) return;
          state = AsyncValue.data(
            currentCategories.copyWith(
              categories: [...currentCategories.categories, r],
            ),
          );
          navigatorKey.currentState!.pop();
        },
      );
    } finally {
      // ⭐️ 4. ไม่ว่าจะสำเร็จหรือล้มเหลว, บอกให้ UI รู้ว่า "เพิ่มข้อมูลเสร็จแล้ว"
      ref.read(categoryActionStateViewModelProvider.notifier).setLoading(false);
    }
  }

  void deleteCategoryById(String id) {
    final currentState = state.value;
    if (currentState == null) return;

    final categoryToRemove = currentState.categories.firstWhere((cg) => cg.id == id);

    final index = currentState.categories.indexOf(categoryToRemove);
    final tempItem = CategoryTemp(
      index: index,
      category: categoryToRemove,
    );

    // 1. อัปเดต UI ทันที (Immutable update)
    final newCategories = currentState.categories.where((tx) => tx.id != id).toList();
    final newTemps = {...currentState.temps, id: tempItem};

    state = AsyncValue.data(
      currentState.copyWith(categories: newCategories, temps: newTemps),
    );

    // 2. ยกเลิก Timer เก่า (ถ้ามี) และสตาร์ท Timer ใหม่เพื่อลบจริง
    _deleteTimers[id]?.cancel();
    _deleteTimers[id] = Timer(const Duration(seconds: 4), () {
      // หน่วงเวลา 4 วินาที
      _finalizeDelete(id);
    });
  }

  void undoDelete(String id) {
    // 1. ยกเลิก Timer ก่อนที่มันจะลบจริง
    _deleteTimers[id]?.cancel();
    _deleteTimers.remove(id);

    final currentState = state.value;
    final tempItem = currentState?.temps[id];

    if (currentState == null || tempItem == null) return;

    // 2. นำ item กลับเข้าที่เดิม (Immutable update)
    final newCategories = [...currentState.categories];
    newCategories.insert(tempItem.index, tempItem.category);

    final newTemps = {...currentState.temps}..remove(id);

    state = AsyncValue.data(
      currentState.copyWith(categories: newCategories, temps: newTemps),
    );
  }

  Future<void> _finalizeDelete(String id) async {
    print('Finalizing delete for $id');
    // 1. เรียก API เพื่อลบข้อมูลจาก Backend
    await _categoryRepository.deleteById(id);

    // 2. เคลียร์ item ออกจาก temps ใน State
    final currentState = state.value;
    if (currentState != null) {
      final newTemps = {...currentState.temps}..remove(id);
      state = AsyncValue.data(currentState.copyWith(temps: newTemps));
    }

    _deleteTimers.remove(id);
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
