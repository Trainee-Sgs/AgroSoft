// ─────────────────────────────────────────────────────────────────────────────
//  auth_provider.dart  (AuthProvider)
//  Fixed:
//    • saveLoginData ledId was null (invalid) → now passes 0 as default
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../widgets/shared_preference_screen.dart';

// ── API endpoint ──────────────────────────────────────────────────────────────
const String _kBaseUrl = 'https://agrosoftware.in/api/mobile/index_new.php';

// ── Login response model ──────────────────────────────────────────────────────
class LoginResponse {
  final bool   error;
  final String errorMsg;
  final int    id;

  const LoginResponse({
    required this.error,
    required this.errorMsg,
    required this.id,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    error:    json['error']     as bool,
    errorMsg: json['error_msg'] as String,
    id:       json['id']        as int,
  );
}

// ── Auth state enum ────────────────────────────────────────────────────────────
enum AuthStatus { idle, loading, success, failure }

// ══════════════════════════════════════════════════════════════════════════════
//  AuthProvider
// ══════════════════════════════════════════════════════════════════════════════
class AuthProvider extends ChangeNotifier {

  AuthStatus _status  = AuthStatus.idle;
  String     _message = '';
  int?       _userId;
  String?    _deviceId;

  // ── Public getters ─────────────────────────────────────────────────────────
  AuthStatus get status    => _status;
  String     get message   => _message;
  int?       get userId    => _userId;
  bool       get isLoading => _status == AuthStatus.loading;

  // ── Initialise on app start ────────────────────────────────────────────────
  /// Call once from main() or SplashScreen after navigation completes.
  Future<void> init() async {
    _deviceId = await _getDeviceId();
    final loggedIn = await SharedPrefService.isLoggedIn();
    if (loggedIn) {
      _userId = await SharedPrefService.getUserId();
      _status = AuthStatus.success;
      notifyListeners();
    }
  }

  // ── Login ──────────────────────────────────────────────────────────────────
  /// [mobile] – 10-digit number (no country code)
  /// [token]  – FCM / push notification token
  /// [type]   – user type sent to API (e.g. "45")
  ///
  /// Returns [true] on success, [false] on failure.
  Future<bool> login({
    required String mobile,
    String token = '',
    String type  = '45',
  }) async {
    _setLoading();

    try {
      // 1. Resolve device ID
      _deviceId ??= await _getDeviceId();

      // 2. Build request body
      final Map<String, String> body = {
        'device_id': _deviceId ?? '0',
        'mobile'   : mobile,
        'token'    : token,
        'type'     : type,
      };

      debugPrint('[AuthProvider] Login params: $body');

      // 3. POST request
      final http.Response response = await http
          .post(
        Uri.parse(_kBaseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      )
          .timeout(const Duration(seconds: 15));

      debugPrint('[AuthProvider] Status: ${response.statusCode}');
      debugPrint('[AuthProvider] Body:   ${response.body}');

      // 4. Parse response
      final Map<String, dynamic> json =
      jsonDecode(response.body) as Map<String, dynamic>;
      final LoginResponse res = LoginResponse.fromJson(json);

      if (!res.error) {
        // ── Success ──────────────────────────────────────────────────────────
        _userId  = res.id;
        _message = res.errorMsg; // e.g. "Valid Mobile No"

        // Persist session — ledId defaults to 0 at this stage (pre-OTP)
        await SharedPrefService.saveLoginData(
          userId   : res.id,
          mobile   : mobile,
          deviceId : _deviceId ?? '0',
          token    : token,
          type     : type,
          ledId    : 0,          // ✅ valid default; real ledId saved after OTP
        );

        _status = AuthStatus.success;
        notifyListeners();
        return true;

      } else {
        // ── API-level error ───────────────────────────────────────────────────
        _setFailure(res.errorMsg);
        return false;
      }

    } on SocketException {
      _setFailure('No internet connection. Please check your network.');
    } on http.ClientException catch (e) {
      _setFailure('Connection error: ${e.message}');
    } on FormatException {
      _setFailure('Unexpected server response. Please try again.');
    } catch (e) {
      _setFailure('Something went wrong: $e');
    }

    return false;
  }

  // ── Logout ────────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await SharedPrefService.clearAll();
    _userId  = null;
    _message = '';
    _status  = AuthStatus.idle;
    notifyListeners();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  void _setLoading() {
    _status  = AuthStatus.loading;
    _message = '';
    notifyListeners();
  }

  void _setFailure(String msg) {
    _status  = AuthStatus.failure;
    _message = msg;
    notifyListeners();
  }

  /// Returns a stable device identifier.
  /// Android → androidId, iOS → identifierForVendor, fallback → '0'
  static Future<String> _getDeviceId() async {
    try {
      final info = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final android = await info.androidInfo;
        return android.id;
      } else if (Platform.isIOS) {
        final ios = await info.iosInfo;
        return ios.identifierForVendor ?? '0';
      }
    } catch (_) {}
    return '0';
  }
}