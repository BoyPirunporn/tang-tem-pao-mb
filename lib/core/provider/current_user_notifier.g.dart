// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentUserNotifier)
const currentUserProvider = CurrentUserNotifierProvider._();

final class CurrentUserNotifierProvider
    extends $NotifierProvider<CurrentUserNotifier, TokenResponseModel?> {
  const CurrentUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserNotifierHash();

  @$internal
  @override
  CurrentUserNotifier create() => CurrentUserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenResponseModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenResponseModel?>(value),
    );
  }
}

String _$currentUserNotifierHash() =>
    r'221c45b4e046d9ba3d42e549fa66f12c82eda027';

abstract class _$CurrentUserNotifier extends $Notifier<TokenResponseModel?> {
  TokenResponseModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TokenResponseModel?, TokenResponseModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TokenResponseModel?, TokenResponseModel?>,
              TokenResponseModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
