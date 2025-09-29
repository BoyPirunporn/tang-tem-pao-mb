// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'networth_history_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NetWorthHistoryViewModel)
const netWorthHistoryViewModelProvider = NetWorthHistoryViewModelProvider._();

final class NetWorthHistoryViewModelProvider
    extends
        $AsyncNotifierProvider<
          NetWorthHistoryViewModel,
          List<NetWorthSnapshotModel>
        > {
  const NetWorthHistoryViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'netWorthHistoryViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$netWorthHistoryViewModelHash();

  @$internal
  @override
  NetWorthHistoryViewModel create() => NetWorthHistoryViewModel();
}

String _$netWorthHistoryViewModelHash() =>
    r'77a263091bcba39e0cf70652f0256e3aa9254c4a';

abstract class _$NetWorthHistoryViewModel
    extends $AsyncNotifier<List<NetWorthSnapshotModel>> {
  FutureOr<List<NetWorthSnapshotModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<NetWorthSnapshotModel>>,
              List<NetWorthSnapshotModel>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<NetWorthSnapshotModel>>,
                List<NetWorthSnapshotModel>
              >,
              AsyncValue<List<NetWorthSnapshotModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
