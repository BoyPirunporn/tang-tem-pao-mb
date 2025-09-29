// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardViewModel)
const dashboardViewModelProvider = DashboardViewModelProvider._();

final class DashboardViewModelProvider
    extends $AsyncNotifierProvider<DashboardViewModel, DashboardState?> {
  const DashboardViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardViewModelHash();

  @$internal
  @override
  DashboardViewModel create() => DashboardViewModel();
}

String _$dashboardViewModelHash() =>
    r'85eada0ee3bead95afb6be03be78d718565764aa';

abstract class _$DashboardViewModel extends $AsyncNotifier<DashboardState?> {
  FutureOr<DashboardState?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<DashboardState?>, DashboardState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardState?>, DashboardState?>,
              AsyncValue<DashboardState?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DashboardSummaryViewModel)
const dashboardSummaryViewModelProvider = DashboardSummaryViewModelProvider._();

final class DashboardSummaryViewModelProvider
    extends
        $AsyncNotifierProvider<
          DashboardSummaryViewModel,
          DashboardSummaryModel?
        > {
  const DashboardSummaryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardSummaryViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardSummaryViewModelHash();

  @$internal
  @override
  DashboardSummaryViewModel create() => DashboardSummaryViewModel();
}

String _$dashboardSummaryViewModelHash() =>
    r'f447211d013ffd890a0adf65c15d52eebb2d113e';

abstract class _$DashboardSummaryViewModel
    extends $AsyncNotifier<DashboardSummaryModel?> {
  FutureOr<DashboardSummaryModel?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<DashboardSummaryModel?>, DashboardSummaryModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<DashboardSummaryModel?>,
                DashboardSummaryModel?
              >,
              AsyncValue<DashboardSummaryModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DashboardChartViewModel)
const dashboardChartViewModelProvider = DashboardChartViewModelProvider._();

final class DashboardChartViewModelProvider
    extends
        $AsyncNotifierProvider<
          DashboardChartViewModel,
          List<DashboardExpenseByCategory>?
        > {
  const DashboardChartViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardChartViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardChartViewModelHash();

  @$internal
  @override
  DashboardChartViewModel create() => DashboardChartViewModel();
}

String _$dashboardChartViewModelHash() =>
    r'97978ca1a489ee0ed4866629f0df5d677e670565';

abstract class _$DashboardChartViewModel
    extends $AsyncNotifier<List<DashboardExpenseByCategory>?> {
  FutureOr<List<DashboardExpenseByCategory>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<DashboardExpenseByCategory>?>,
              List<DashboardExpenseByCategory>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DashboardExpenseByCategory>?>,
                List<DashboardExpenseByCategory>?
              >,
              AsyncValue<List<DashboardExpenseByCategory>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DashboardRecentViewModel)
const dashboardRecentViewModelProvider = DashboardRecentViewModelProvider._();

final class DashboardRecentViewModelProvider
    extends
        $AsyncNotifierProvider<
          DashboardRecentViewModel,
          List<TransactionModel>?
        > {
  const DashboardRecentViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRecentViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRecentViewModelHash();

  @$internal
  @override
  DashboardRecentViewModel create() => DashboardRecentViewModel();
}

String _$dashboardRecentViewModelHash() =>
    r'a478ebcaa7c83b1447154b318a372e21f438bc5f';

abstract class _$DashboardRecentViewModel
    extends $AsyncNotifier<List<TransactionModel>?> {
  FutureOr<List<TransactionModel>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<TransactionModel>?>,
              List<TransactionModel>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<TransactionModel>?>,
                List<TransactionModel>?
              >,
              AsyncValue<List<TransactionModel>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DashboardFilter)
const dashboardFilterProvider = DashboardFilterProvider._();

final class DashboardFilterProvider
    extends $NotifierProvider<DashboardFilter, DateTimeRange<DateTime>?> {
  const DashboardFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardFilterHash();

  @$internal
  @override
  DashboardFilter create() => DashboardFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTimeRange<DateTime>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTimeRange<DateTime>?>(value),
    );
  }
}

String _$dashboardFilterHash() => r'fbf9ee410c048f2e7f78f946e35629c39182c1dc';

abstract class _$DashboardFilter extends $Notifier<DateTimeRange<DateTime>?> {
  DateTimeRange<DateTime>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<DateTimeRange<DateTime>?, DateTimeRange<DateTime>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTimeRange<DateTime>?, DateTimeRange<DateTime>?>,
              DateTimeRange<DateTime>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
