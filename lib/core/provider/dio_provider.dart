import 'dart:developer' as logger;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tang_tem_pao_mb/core/constant/server_constant.dart';
import 'package:tang_tem_pao_mb/core/provider/current_user_notifier.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/auth/model/token_response.dart';
import 'package:tang_tem_pao_mb/feature/auth/repository/auth_local_repository.dart';
import 'package:tang_tem_pao_mb/feature/auth/view/pages/auth_page.dart';
import 'package:tang_tem_pao_mb/feature/auth/viewmodel/auth_viewmodel.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: ServerConstant.serverUrl));
  dio.interceptors.add(
    QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        final token = ref.watch(authLocalRepositoryProvider).getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException ex, handler) async {
        logger.log("Error ${ex.response}");
        if (ex.response?.statusCode == 401) {
          logger.log("Intercepted 401. Attempting to refresh token...");
          try {
            // 1. พยายาม Refresh Token
            final newToken = await _performRefreshToken(ref);

            if (newToken != null) {
              logger.log("Token refreshed. Retrying the request.");
              // 2. ถ้าสำเร็จ, ยิง request เดิมซ้ำด้วย token ใหม่
              final response = await _retryRequest(ex.requestOptions, newToken);
              return handler.resolve(response); // คืนค่า response ใหม่
            } else {
              // ถ้า Refresh ล้มเหลว ก็ปล่อยให้ Error เดิมทำงานต่อไป
              logger.log("Refresh token failed. Propagating original error.");
              _logout(ref);
              return handler.next(ex);
            }
          } catch (e) {
            logger.log(
              "Exception during refresh token. Propagating original error.",
            );
            _logout(ref);
            return handler.next(ex);
          }
        }
        if (ex.response?.statusCode == 400) {
          handler.reject(
            DioException(
              requestOptions: ex.requestOptions,
              response: ex.response,
              error: '${ex.response?.data['errors']}',
              type: DioExceptionType.badResponse,
            ),
          );
          return;
        }
        return handler.next(ex);
      },
    ),
  );

  return dio;
});

// Provider สำหรับ Dio instance ที่ "สะอาด" ไม่มี Interceptor
// ใช้สำหรับ Login, Register, และ Refresh Token เพื่อไม่ให้เกิด Loop
final cleanDioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: ServerConstant.serverUrl));
});

Future<String?> _performRefreshToken(Ref ref) async {
  final refreshToken = ref.read(authLocalRepositoryProvider).getRefreshToken();
  if (refreshToken == null) return null;

  final authLocalRepository = ref.read(authLocalRepositoryProvider);
  final currentUserNotifier = ref.read(currentUserProvider.notifier);

  try {
    final dio = ref.read(cleanDioProvider);
    final response = await dio.post(
      '/auth/refresh-token',
      data: {
        'refreshToken': refreshToken,
        'accessToken': authLocalRepository.getToken(),
      },
    );

    if (response.statusCode == 200) {
      final tokenResponse = TokenResponseModel.fromMap(
        response.data['payload'],
      );
      ref.read(authViewModelProvider.notifier).loginSuccess(tokenResponse);
      return tokenResponse.token;
    } else {
      logger.log("🔴 Refresh token failed, logging out.");
      await authLocalRepository.clearAll();
      currentUserNotifier.removeUser();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await authLocalRepository.clearAll();
        currentUserNotifier.removeUser();
        navigatorKey.currentState?.pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => AuthPage(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 200),
          ),
          (_) => false,
        );
        DialogProvider.instance.showErrorDialog(
          title: "หมดเวลา",
          message: "กรุณาเข้าสู่ระบบใหม่",
        );
      });
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<Response<dynamic>> _retryRequest(
  RequestOptions requestOptions,
  String newToken,
) async {
  final options = Options(
    method: requestOptions.method,
    headers: {'Authorization': 'Bearer $newToken'},
  );
  return Dio(BaseOptions(baseUrl: ServerConstant.serverUrl)).request<dynamic>(
    requestOptions.path,
    data: requestOptions.data,
    queryParameters: requestOptions.queryParameters,
    options: options,
  );
}

void _logout(Ref ref) {
  ref.read(authViewModelProvider.notifier).logout();
}
