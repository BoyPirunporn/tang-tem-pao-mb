// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_signup_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthSignUpViewModel)
const authSignUpViewModelProvider = AuthSignUpViewModelProvider._();

final class AuthSignUpViewModelProvider
    extends $NotifierProvider<AuthSignUpViewModel, AsyncValue<ApiResponse>?> {
  const AuthSignUpViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSignUpViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSignUpViewModelHash();

  @$internal
  @override
  AuthSignUpViewModel create() => AuthSignUpViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ApiResponse>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ApiResponse>?>(value),
    );
  }
}

String _$authSignUpViewModelHash() =>
    r'f46db32aa8c3ee984cd49c43b9e4f4e531468a32';

abstract class _$AuthSignUpViewModel
    extends $Notifier<AsyncValue<ApiResponse>?> {
  AsyncValue<ApiResponse>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<ApiResponse>?, AsyncValue<ApiResponse>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ApiResponse>?, AsyncValue<ApiResponse>?>,
              AsyncValue<ApiResponse>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
