import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tang_tem_pao_mb/feature/auth/model/token_response.dart';

part 'current_user_notifier.g.dart';
@Riverpod(keepAlive: true)
class CurrentUserNotifier extends _$CurrentUserNotifier {
  @override
  TokenResponseModel? build(){
    return null;
  }

  void addUser(TokenResponseModel token){
    state = token;
  }
  void removeUser(){
    state = null;
  }
}
