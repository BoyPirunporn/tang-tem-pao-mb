import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_action_state_viewmodel.g.dart';

@riverpod
class CategoryActionStateViewModel extends _$CategoryActionStateViewModel {
  @override
  bool build() => false; // ค่าเริ่มต้นคือ false (ไม่ได้กำลังโหลด)

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
