import 'dart:developer' as logger;

import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/core/model/api_response.dart';
import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
import 'package:tang_tem_pao_mb/feature/auth/repository/auth_repository.dart';

part 'auth_signup_viewmodel.g.dart';

@riverpod
class AuthSignUpViewModel extends _$AuthSignUpViewModel {
  late AuthRepository _authRepository;

  @override
  AsyncValue<ApiResponse>? build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return null;
  }

  Future<void> signUp({
    required String name,
    required String username,
    required String password,
  }) async {
    state = AsyncValue.loading();
    final res = await _authRepository.signup(
      name: name,
      username: username,
      password: password,
    );

    switch (res) {
      case Left(value: final l):
        state = AsyncValue.error(l.message, StackTrace.current);
        DialogProvider.instance.showErrorDialog(title: "Error", message: l.message);
        logger.log('❌ Failure: ${l.message}');
        break;

      case Right(value: final r):
        logger.log('✅ Success: $r');
        state = AsyncValue.data(r);
        break;
    }
  }
}
