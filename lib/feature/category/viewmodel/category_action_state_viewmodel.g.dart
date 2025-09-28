// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_action_state_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryActionStateViewModel)
const categoryActionStateViewModelProvider =
    CategoryActionStateViewModelProvider._();

final class CategoryActionStateViewModelProvider
    extends $NotifierProvider<CategoryActionStateViewModel, bool> {
  const CategoryActionStateViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryActionStateViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryActionStateViewModelHash();

  @$internal
  @override
  CategoryActionStateViewModel create() => CategoryActionStateViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$categoryActionStateViewModelHash() =>
    r'092a8e1592f8ffc50504b7eaeeeb6682202f48ff';

abstract class _$CategoryActionStateViewModel extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
