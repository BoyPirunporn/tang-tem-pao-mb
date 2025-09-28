import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tang_tem_pao_mb/feature/auth/model/token_response.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  late SharedPreferences _sharedPreferences;

  Future<void>init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token){
    if(token != null){
      _sharedPreferences.setString('token',token);
    }
  }
  void setRefreshToken(String? refreshToken){
    if(refreshToken != null){
      _sharedPreferences.setString("refreshToken",refreshToken);
    }
  }

  void setAuthorize(TokenResponseModel? token){
    if(token != null){
      _sharedPreferences.setString("authorize", token.toJson());
    }
  }

  String? getToken(){
    return _sharedPreferences.getString('token');
  }

  String? getRefreshToken(){
    return _sharedPreferences.getString("refreshToken");
  }

  Future<void> clearAll()async{
    await _sharedPreferences.clear();
  }
  TokenResponseModel? getAuthorize(){
    String? authorize = _sharedPreferences.getString("authorize");
    if(authorize == null){
      return null;
    }
    return TokenResponseModel.fromJson(authorize);
  }
}