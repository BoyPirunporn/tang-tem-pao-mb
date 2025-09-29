// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TransactionViewModel)
const transactionViewModelProvider = TransactionViewModelProvider._();

final class TransactionViewModelProvider
    extends $AsyncNotifierProvider<TransactionViewModel, TransactionState> {
  const TransactionViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionViewModelHash();

  @$internal
  @override
  TransactionViewModel create() => TransactionViewModel();
}

String _$transactionViewModelHash() =>
    r'4dafc68a018a0025b4603e03cd22e986a9f6cbbd';

abstract class _$TransactionViewModel extends $AsyncNotifier<TransactionState> {
  FutureOr<TransactionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<TransactionState>, TransactionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TransactionState>, TransactionState>,
              AsyncValue<TransactionState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
