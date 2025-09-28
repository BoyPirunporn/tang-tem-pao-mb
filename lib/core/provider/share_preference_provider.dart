import 'package:shared_preferences/shared_preferences.dart';



class SharePreferenceProvider {
  static final SharePreferenceProvider instance = SharePreferenceProvider._();
  SharePreferenceProvider._();

  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }
}