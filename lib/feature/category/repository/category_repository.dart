import 'dart:convert';
import 'dart:developer' as logger;

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/enum/category_status_enum.dart';
import 'package:tang_tem_pao_mb/core/enum/transaction_type_enum.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/provider/dio_provider.dart';
import 'package:tang_tem_pao_mb/feature/category/model/category_model.dart';

part 'category_repository.g.dart';

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final Dio dio = ref.watch(dioProvider);
  return CategoryRepository(dio);
}

class CategoryRepository {
  final Dio _client;
  CategoryRepository(this._client);

  Future<Either<AppFailure, List<CategoryModel>>> getAllCategory({
    TransactionType? type,
    String? name,
    CancelToken? cancelToken,
  }) async {
    try {
      final  queryParameters = {'type': type != null ? type.getValue() : null, 'name': name};
      logger.log("QUERY : $queryParameters");
      final res = await _client.get(
        "/category",
        queryParameters: queryParameters,

        cancelToken: cancelToken,
      );
      Map<String, dynamic> resBodyCategoryMap = res.data;
      if (res.statusCode != 200) {
        return Left(AppFailure(resBodyCategoryMap['message']));
      }
      List<CategoryModel> categories =
          (resBodyCategoryMap['payload'] as List<dynamic>)
              .map((data) => CategoryModel.fromMapResponse(data))
              .toList();
      // logger.log("Categories : ${categories.toString()}");
      //await Future.delayed(const Duration(seconds: 2));
      return Right(categories);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure("ไม่สามารถโหลดข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่"));
    }
  }

  Future<Either<AppFailure, CategoryModel>> createCategory(
    String name,
    TransactionType type,
    CategoryStatus status,
  ) async {
    try {
      final String payload = jsonEncode({
        'name': name,
        'type': type.getValue(),
        'status': status.getValue(),
      });
      logger.log("PAYLOAD : $payload");
      final res = await _client.post("/category", data: payload);
      Map<String, dynamic> resBodyCategoryMap = res.data;
      if (res.statusCode != 200) {
        return Left(AppFailure(resBodyCategoryMap['message']));
      }
      CategoryModel category = CategoryModel.fromMapResponse(
        resBodyCategoryMap['payload'],
      );
      logger.log("Category : ${category.toString()}");
      //await Future.delayed(const Duration(seconds: 2));
      return Right(category);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure("ไม่สามารถโหลดข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่"));
    }
  }

  Future<Either<AppFailure, CategoryModel>> updateCategory(
    String id,
    String color,
    String name,
    TransactionType type,
    CategoryStatus status,
  ) async {
    try {
      final String payload = jsonEncode({
        'name': name,
        'color': color,
        'type': type.getValue(),
        'status': status.getValue(),
      });
      logger.log("PAYLOAD : $payload");
      final res = await _client.put("/category/$id", data: payload);
      Map<String, dynamic> resBodyCategoryMap = res.data;
      if (res.statusCode != 200) {
        return Left(AppFailure(resBodyCategoryMap['message']));
      }
      CategoryModel category = CategoryModel.fromMapResponse(
        resBodyCategoryMap['payload'],
      );
      logger.log("Category : ${category.toString()}");
      //await Future.delayed(const Duration(seconds: 2));
      return Right(category);
    } catch (e) {
      logger.log(e.toString());
      return Left(AppFailure("ไม่สามารถโหลดข้อมูลได้ กรุณาติดต่อเจ้าหน้าที่"));
    }
  }

   Future<Either<AppFailure, bool>> deleteById(String id) async {
    try {
      await _client.delete("/category/$id");
      return Right(true);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
