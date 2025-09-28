// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionFilter)
const transactionFilterProvider = TransactionFilterProvider._();

final class TransactionFilterProvider
    extends $NotifierProvider<TransactionFilter, TransactionFilterState> {
  const TransactionFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionFilterHash();

  @$internal
  @override
  TransactionFilter create() => TransactionFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionFilterState>(value),
    );
  }
}

String _$transactionFilterHash() => r'6a52333c4c2226b970b1ca6b145971bdc740d07f';

abstract class _$TransactionFilter extends $Notifier<TransactionFilterState> {
  TransactionFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<TransactionFilterState, TransactionFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionFilterState, TransactionFilterState>,
              TransactionFilterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
