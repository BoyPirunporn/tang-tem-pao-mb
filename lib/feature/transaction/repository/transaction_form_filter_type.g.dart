// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_form_filter_type.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionFormFilterType)
const transactionFormFilterTypeProvider = TransactionFormFilterTypeProvider._();

final class TransactionFormFilterTypeProvider
    extends $NotifierProvider<TransactionFormFilterType, TransactionType> {
  const TransactionFormFilterTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionFormFilterTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionFormFilterTypeHash();

  @$internal
  @override
  TransactionFormFilterType create() => TransactionFormFilterType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionType>(value),
    );
  }
}

String _$transactionFormFilterTypeHash() =>
    r'b8e356a0f98776fc823f382ebc4c8c76c5a6e04c';

abstract class _$TransactionFormFilterType extends $Notifier<TransactionType> {
  TransactionType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TransactionType, TransactionType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionType, TransactionType>,
              TransactionType,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
