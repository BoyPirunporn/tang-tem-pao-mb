// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer' as logger;

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:tang_tem_pao_mb/core/constant/server_constant.dart';
// import 'package:tang_tem_pao_mb/core/provider/current_user_notifier.dart';
// import 'package:tang_tem_pao_mb/core/provider/dialog_provider.dart';
// import 'package:tang_tem_pao_mb/feature/auth/model/token_response.dart';
// import 'package:tang_tem_pao_mb/feature/auth/repository/auth_local_repository.dart';
// import 'package:tang_tem_pao_mb/feature/auth/view/pages/auth_page.dart';

// /// This provider creates a singleton instance of our custom HTTP client.
// /// The rest of the application should use this provider to make API calls.
// final httpClientProvider = Provider<http.Client>((Ref ref) {
//   final authLocalRepository = ref.watch(authLocalRepositoryProvider);
//   final currentUserNotifier = ref.watch(currentUserProvider.notifier);
//   return InterceptedClient(
//     currentUserNotifier: currentUserNotifier,
//     authLocalRepository: authLocalRepository,
//     baseUrl: ServerConstant.serverUrl,
//   );
// });

// class InterceptedClient extends http.BaseClient {
//   final AuthLocalRepository _authLocalRepository;
//   final CurrentUserNotifier _currentUserNotifier;

//   final String baseUrl;
//   final http.Client _inner = http.Client();
//   Completer<String?>? _refreshTokenCompleter;

//   InterceptedClient({
//     required CurrentUserNotifier currentUserNotifier,
//     required AuthLocalRepository authLocalRepository,
//     required this.baseUrl,
//   }) : _authLocalRepository = authLocalRepository,
//        _currentUserNotifier = currentUserNotifier;

//   Future<TokenResponseModel?> _performRefreshToken(
//     String token,
//     String refreshToken,
//   ) async {
//     try {
//       final cleanClient = http.Client();
//       final response = await cleanClient.post(
//         Uri.parse('$baseUrl/auth/refresh-token'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'refreshToken': refreshToken, 'accessToken': token}),
//       );

//       if (response.statusCode == 200) {
//         final tokenResponse = TokenResponseModel.fromMap(
//           jsonDecode(response.body)['payload'],
//         );
//         // บันทึก Token ใหม่
//         _authLocalRepository.setAuthorize(tokenResponse);
//         _authLocalRepository.setToken(tokenResponse.token);
//         _authLocalRepository.setRefreshToken(tokenResponse.refreshToken);
//         _currentUserNotifier.addUser(tokenResponse);
//         logger.log("✅ Token refreshed successfully!");
//         return tokenResponse;
//       } else {
//         logger.log("🔴 Refresh token failed, logging out.");
//         await _authLocalRepository.clearAll();
//         _currentUserNotifier.removeUser();
//         WidgetsBinding.instance.addPostFrameCallback((_) async {
//           await _authLocalRepository.clearAll();
//           _currentUserNotifier.removeUser();
//           navigatorKey.currentState?.pushAndRemoveUntil(
//             PageRouteBuilder(
//               pageBuilder: (_, __, ___) => AuthPage(),
//               transitionsBuilder: (_, animation, __, child) {
//                 return FadeTransition(opacity: animation, child: child);
//               },
//               transitionDuration: const Duration(milliseconds: 200),
//             ),
//             (_) => false,
//           );
//           DialogProvider.instance.showErrorDialog(
//             title: "หมดเวลา",
//             message: "กรุณาเข้าสู่ระบบใหม่",
//           );
//         });
//         return null;
//       }
//     } catch (e) {
//       logger.log("🔴 Error during refresh token, logging out: $e");
//       await _authLocalRepository.clearAll();
//       _currentUserNotifier.removeUser();
//       return null;
//     }
//   }

//   @override
//   Future<http.StreamedResponse> send(http.BaseRequest request) async {
//     final initialRequest = _createRequest(request);
//     final response = await _inner.send(initialRequest);

//     if (response.statusCode == 401) {
//       logger.log("Intercepted a 401 Unauthorized response.");

//       // ⭐️ 2. แก้ไข Logic การจัดการ Completer ให้สมบูรณ์
//       if (_refreshTokenCompleter == null) {
//         logger.log("No refresh in progress. Starting a new one.");
//         _refreshTokenCompleter = Completer<String?>();
//         final refreshToken = _authLocalRepository.getRefreshToken();
//         final token = _authLocalRepository.getToken();
//         if (refreshToken == null || token == null) throw Exception('No token');

//         // ทำการ refresh และเมื่อเสร็จแล้วให้ complete และเคลียร์ตัวเอง
//         _performRefreshToken(token, refreshToken).then((newToken) {
//           _refreshTokenCompleter!.complete(newToken?.token);
//           _refreshTokenCompleter = null; // รีเซ็ตเมื่อทำงานเสร็จ
//         });
//       } else {
//         logger.log(
//           "A refresh is already in progress. Waiting for it to complete.",
//         );
//       }

//       final newToken = await _refreshTokenCompleter!.future;

//       if (newToken != null) {
//         logger.log("Retrying the original request with the new token.");
//         return _retryRequest(request, newToken);
//       } else {
//         logger.log(
//           "Refresh failed or no new token. Returning original 401 response.",
//         );
//         return response;
//       }
//     }
//     return response;
//   }

//   // Helper สำหรับสร้าง Request เริ่มต้น
//   http.BaseRequest _createRequest(http.BaseRequest request) {
//     final newUrl = Uri.parse(baseUrl + request.url.toString());
//     final token = _authLocalRepository.getToken();
//     final headers = Map<String, String>.from(request.headers);
//     logger.log("TOKEN : $token");
//     if (!headers.containsKey('Content-Type')) {
//       headers['Content-Type'] = 'application/json';
//     }
//     if (token != null) {
//       headers['Authorization'] = 'Bearer $token';
//     }
//     return _copyRequestWith(request, headers: headers, url: newUrl);
//   }

//   // Helper สำหรับ Retry Request ด้วย Token ใหม่
//   Future<http.StreamedResponse> _retryRequest(
//     http.BaseRequest request,
//     String newToken,
//   ) async {
//     final newUrl = Uri.parse(baseUrl + request.url.toString());
//     final headers = Map<String, String>.from(request.headers);
//     headers['Authorization'] = 'Bearer $newToken'; // ใส่ Token ใหม่

//     final retryRequest = _copyRequestWith(
//       request,
//       headers: headers,
//       url: newUrl,
//     );
//     return _inner.send(retryRequest);
//   }

//   // Helper สำหรับ Copy Request (รวม _copyRequest เดิม)
//   http.BaseRequest _copyRequestWith(
//     http.BaseRequest original, {
//     Map<String, String>? headers,
//     Uri? url,
//   }) {
//     if (original is http.Request) {
//       final req = http.Request(original.method, url ?? original.url)
//         ..bodyBytes = original.bodyBytes
//         ..followRedirects = original.followRedirects
//         ..maxRedirects = original.maxRedirects
//         ..persistentConnection = original.persistentConnection;
//       if (headers != null) req.headers.addAll(headers);
//       return req;
//     }
//     throw UnimplementedError(
//       'Request type ${original.runtimeType} not supported.',
//     );
//   }
// }
