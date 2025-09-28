// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_recent_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardRecentViewmodel)
const dashboardRecentViewmodelProvider = DashboardRecentViewmodelProvider._();

final class DashboardRecentViewmodelProvider
    extends
        $AsyncNotifierProvider<
          DashboardRecentViewmodel,
          List<TransactionModel>
        > {
  const DashboardRecentViewmodelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRecentViewmodelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRecentViewmodelHash();

  @$internal
  @override
  DashboardRecentViewmodel create() => DashboardRecentViewmodel();
}

String _$dashboardRecentViewmodelHash() =>
    r'14fbc541f2253cf96a809d4248726ba6493078e0';

abstract class _$DashboardRecentViewmodel
    extends $AsyncNotifier<List<TransactionModel>> {
  FutureOr<List<TransactionModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<TransactionModel>>, List<TransactionModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransactionModel>>,
                List<TransactionModel>
              >,
              AsyncValue<List<TransactionModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
