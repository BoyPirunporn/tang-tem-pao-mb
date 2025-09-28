import 'dart:io';

class ServerConstant {
  static final String serverUrl = Platform.isAndroid ? 'http://10.0.2.2:8080/api/v1' : 'http://127.0.0.1:8080/api/v1';
}