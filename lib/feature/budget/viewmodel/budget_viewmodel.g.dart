// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BudgetViewModel)
const budgetViewModelProvider = BudgetViewModelProvider._();

final class BudgetViewModelProvider
    extends $AsyncNotifierProvider<BudgetViewModel, List<BudgetModel>> {
  const BudgetViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetViewModelHash();

  @$internal
  @override
  BudgetViewModel create() => BudgetViewModel();
}

String _$budgetViewModelHash() => r'd64627d280c8a5cde33dbef1113a25d519ab4c55';

abstract class _$BudgetViewModel extends $AsyncNotifier<List<BudgetModel>> {
  FutureOr<List<BudgetModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<BudgetModel>>, List<BudgetModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BudgetModel>>, List<BudgetModel>>,
              AsyncValue<List<BudgetModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(BudgetFilter)
const budgetFilterProvider = BudgetFilterProvider._();

final class BudgetFilterProvider
    extends $NotifierProvider<BudgetFilter, BudgetStatus> {
  const BudgetFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'budgetFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$budgetFilterHash();

  @$internal
  @override
  BudgetFilter create() => BudgetFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BudgetStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BudgetStatus>(value),
    );
  }
}

String _$budgetFilterHash() => r'c409c510c1c8663095ff4df827d5bbdb8980590e';

abstract class _$BudgetFilter extends $Notifier<BudgetStatus> {
  BudgetStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<BudgetStatus, BudgetStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BudgetStatus, BudgetStatus>,
              BudgetStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
