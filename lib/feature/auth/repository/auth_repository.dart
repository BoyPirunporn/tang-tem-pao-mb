import 'dart:developer' as logger;

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tang_tem_pao_mb/core/failure/app_failure.dart';
import 'package:tang_tem_pao_mb/core/model/api_response.dart';
import 'package:tang_tem_pao_mb/core/model/api_response_bad.dart';
import 'package:tang_tem_pao_mb/core/provider/dio_provider.dart';
import 'package:tang_tem_pao_mb/feature/auth/model/token_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // AuthRepository จะ "ขอ" httpClient ที่เราสร้างไว้มาใช้งาน
  final dio = ref.watch(cleanDioProvider);
  return AuthRepository(dio);
});

class AuthRepository {
  final Dio _dio;
  AuthRepository(this._dio);

  Future<Either<AppFailure, ApiResponse>> signup({
    required String name,
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {'name': name, 'username': username, 'password': password},
      );
      final resBodyMap = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        if (response.statusCode == 400) {
          final ApiResponseBad bad = ApiResponseBad.fromJson(response.data);
          return Left(AppFailure(bad.errors.toString()));
        }
        final ApiResponse res = ApiResponse.fromJson(response.data);
        return Left(AppFailure(res.message));
      }
      return Right(ApiResponse.fromMap(resBodyMap));
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, TokenResponseModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login-mobile',
        data: {'username': username, 'password': password},
      );
      final resBodyMap = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        if (response.statusCode == 400) {
          final ApiResponseBad bad = ApiResponseBad.fromJson(response.data);
          return Left(AppFailure(bad.errors.toString()));
        }
        final ApiResponse res = ApiResponse.fromJson(response.data);
        return Left(AppFailure(res.message));
      }
      return Right(TokenResponseModel.fromMap(resBodyMap['payload']));
    } catch (e) {
      if (e is DioException) {
        return Left(
          AppFailure(e.response!.data['message'] ?? e.message),
        );
      }
      return Left(AppFailure("เกิดข้อผิดพลาด"));
    }
  }

  Future<Either<AppFailure, TokenResponseModel>> refreshToken(
    String token,
    String refreshToken,
  ) async {
    try {
      logger.log("REFRESHTOKEN HERE IS CALLED");
      final response = await _dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken, 'accessToken': token},
      );
      logger.log('response : ${response.data}');

      if (response.statusCode == 200) {
        final tokenResponse = TokenResponseModel.fromMap(
          response.data['payload'],
        );
        return Right(tokenResponse);
      }
      return Left(AppFailure('Failed to refresh token'));
    } catch (e) {
      logger.log("${e.toString()}");
      return Left(AppFailure(e.toString()));
    }
  }
}
