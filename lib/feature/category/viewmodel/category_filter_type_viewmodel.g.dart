// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_filter_type_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoryFilterTypeViewModel)
const categoryFilterTypeViewModelProvider =
    CategoryFilterTypeViewModelProvider._();

final class CategoryFilterTypeViewModelProvider
    extends
        $AsyncNotifierProvider<
          CategoryFilterTypeViewModel,
          List<CategoryModel>
        > {
  const CategoryFilterTypeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryFilterTypeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryFilterTypeViewModelHash();

  @$internal
  @override
  CategoryFilterTypeViewModel create() => CategoryFilterTypeViewModel();
}

String _$categoryFilterTypeViewModelHash() =>
    r'efd692421e820ed1a7df925ae2ac47b34ddbe390';

abstract class _$CategoryFilterTypeViewModel
    extends $AsyncNotifier<List<CategoryModel>> {
  FutureOr<List<CategoryModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<CategoryModel>>, List<CategoryModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CategoryModel>>, List<CategoryModel>>,
              AsyncValue<List<CategoryModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
