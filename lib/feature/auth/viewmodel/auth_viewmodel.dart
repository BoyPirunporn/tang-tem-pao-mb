import 'dart:developer' as logger;

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/provider/current_user_notifier.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/auth/model/token_response.dart';
import 'package:tang_tem_pao_mb/feature/auth/repository/auth_local_repository.dart';
import 'package:tang_tem_pao_mb/feature/auth/repository/auth_repository.dart';
import 'package:tang_tem_pao_mb/feature/auth/view/pages/auth_page.dart';

part 'auth_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  late AuthLocalRepository _authLocalRepository;
  late AuthRepository _authRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<TokenResponseModel>? build() {
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _authRepository = ref.watch(authRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);
    return null;
  }

  Future<void> initSharedPreferences() async {
    await _authLocalRepository.init();
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final res = await _authRepository.login(
      username: username,
      password: password,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(l.message, StackTrace.current);
        DialogProvider.instance.showErrorDialog(
          title: "Error",
          message: l.message,
        );
        logger.log('❌ Failure: ${l.message}');
        return false;
      case Right(value: final r):
        logger.log('✅ Success: $r');
        loginSuccess(r);
        return true;
    }
    
  }

  AsyncValue<TokenResponseModel>? loginSuccess(TokenResponseModel response) {
    _authLocalRepository.setToken(response.token);
    _authLocalRepository.setRefreshToken(response.refreshToken);
    _authLocalRepository.setAuthorize(response);
    _currentUserNotifier.addUser(response);
    return state = AsyncValue.data(response);
  }

  Future<void> getValidToken() async {
    logger.log("GET VALID TOKEN");
    final tokenModel = _authLocalRepository.getAuthorize();

    if (tokenModel == null) {
      logger.log("UNAUTHORIZE");
      // ✅ อัปเดต state ว่าไม่มีข้อมูล
      return state = null;
    }

    logger.log("isExpires ${tokenModel.isExpired}");

    if (!tokenModel.isExpired) {
      _currentUserNotifier.addUser(tokenModel);
      state = AsyncValue.data(tokenModel); // ✅ อัปเดต state ว่ามีข้อมูลแล้ว
      return;
    }

    // กรณี 3: Token หมดอายุ, ต้องทำการ Refresh
    final res = await _authRepository.refreshToken(
      tokenModel.token,
      tokenModel.refreshToken,
    );

    // if (!ref.mounted) return;

    res.match(
      (l) {
        logger.log("ERROR ${l.message}");
        // เมื่อ Refresh ไม่ผ่าน, เราจะ logout ซึ่งจะตั้ง state เป็น null ให้เอง
        DialogProvider.instance.showErrorDialog(
          title: "Session หมดอายุ",
          message: "กรุณาเข้าสู่ระบบใหม่",
          onOk: () {
            logout();
          },
        );
        state = AsyncValue.error(l.message, StackTrace.current);
      },
      (r) {
        state = loginSuccess(r); // ✅ อัปเดต state ว่ามีข้อมูลใหม่แล้ว
      },
    );
  }

  /// สำหรับ init app
  Future<void> getAuthorize() async {
    state = const AsyncValue.loading();
    // อ่านข้อมูลจาก Local Storage
    final tokenModel = _authLocalRepository.getAuthorize();
    logger.log("TOKENMODEL :$tokenModel");
    if (tokenModel != null) {
      // ถ้ามีข้อมูล ก็อัปเดต state
      _currentUserNotifier.addUser(tokenModel);
      state = AsyncValue.data(tokenModel);
    } else {
      // ถ้าไม่มี ก็ตั้ง state เป็น null
      state = null;
    }
  }

  Future<void> logout() async {
    await _authLocalRepository
        .clearAll(); // Assuming you have a method to clear tokens
    _currentUserNotifier.removeUser();
    state = null;
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
  }
}

@riverpod
Future<void> authInitializer(Ref ref) async {
  await Future.delayed(const Duration(seconds: 2));
  await ref.read(authLocalRepositoryProvider).init();
  await ref.read(authViewModelProvider.notifier).getAuthorize();
}
