// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BalanceViewModel)
const balanceViewModelProvider = BalanceViewModelProvider._();

final class BalanceViewModelProvider
    extends $AsyncNotifierProvider<BalanceViewModel, BalanceState> {
  const BalanceViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'balanceViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$balanceViewModelHash();

  @$internal
  @override
  BalanceViewModel create() => BalanceViewModel();
}

String _$balanceViewModelHash() => r'baf0e427d9164edf936c95dd6f7e57563da445a6';

abstract class _$BalanceViewModel extends $AsyncNotifier<BalanceState> {
  FutureOr<BalanceState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<BalanceState>, BalanceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BalanceState>, BalanceState>,
              AsyncValue<BalanceState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
