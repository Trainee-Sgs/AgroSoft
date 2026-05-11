// ─────────────────────────────────────────────────────────────────────────────
//  otp_verify_provider.dart
//  Fixed:
//    • URL: POST to _baseUrl directly (not _baseUrl/login)
//    • Login body matches what the API actually expects
//    • setLedId() added — LoginScreen AuthProvider.login() result-ஐ pass பண்ண
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../provider_module/location_service.dart';
import '../widgets/shared_preference_screen.dart';

class OtpVerifyProvider extends ChangeNotifier {

  bool   _isLoading = false;
  String _message   = '';
  int?   _ledId;
  String _mobile    = '';

  bool   get isLoading => _isLoading;
  String get message   => _message;
  int?   get ledId     => _ledId;
  String get mobile    => _mobile;

  static const String _baseUrl =
      'https://agrosoftware.in/api/mobile/index.php';

  // ══════════════════════════════════════════════════════════════════════════
  //  Set ledId externally
  //  LoginScreen → AuthProvider.login() → id: 659 → setLedId(659)
  // ══════════════════════════════════════════════════════════════════════════
  void setLedId(int id, {String mobile = ''}) {
    _ledId  = id;
    if (mobile.isNotEmpty) _mobile = mobile;
    debugPrint('════════════════════════════════════════');
    debugPrint('[OtpVerifyProvider] setLedId called');
    debugPrint('[OtpVerifyProvider] _ledId  = $_ledId');
    debugPrint('[OtpVerifyProvider] _mobile = $_mobile');
    debugPrint('════════════════════════════════════════');
    notifyListeners();
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 1 — Login (sends OTP)
  // ══════════════════════════════════════════════════════════════════════════
  Future<bool> login({required String mobile}) async {
    _setLoading(true);
    _message = '';

    final Map<String, String> body = {
      'type'  : '1',
      'mobile': mobile,
    };

    debugPrint('════════════════════════════════════════');
    debugPrint('[LOGIN] REQUEST');
    debugPrint('[LOGIN] URL  : $_baseUrl');
    debugPrint('[LOGIN] Body : $body');
    debugPrint('════════════════════════════════════════');

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      debugPrint('[LOGIN] Status Code : ${response.statusCode}');
      debugPrint('[LOGIN] Raw Body    : ${response.body}');

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint('[LOGIN] Parsed JSON : $data');
      debugPrint('[LOGIN] error       : ${data['error']}');
      debugPrint('[LOGIN] error_msg   : ${data['error_msg']}');
      debugPrint('[LOGIN] led_id      : ${data['led_id']}');
      debugPrint('════════════════════════════════════════');

      if (response.statusCode == 200 && data['error'] == false) {
        _ledId   = data['led_id'] as int;
        _mobile  = mobile;
        _message = data['error_msg'] ?? 'OTP sent successfully';

        debugPrint('[LOGIN] ✅ SUCCESS  _ledId=$_ledId');
        _setLoading(false);
        return true;
      } else {
        _message = data['error_msg'] ?? 'Login failed. Please try again.';
        debugPrint('[LOGIN] ❌ FAILED — $_message');
        _setLoading(false);
        return false;
      }
    } catch (e, stack) {
      _message = 'Network error. Please check your connection.';
      debugPrint('[LOGIN] ❌ EXCEPTION : $e');
      debugPrint('[LOGIN] STACKTRACE  : $stack');
      _setLoading(false);
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 2 — Verify OTP
  // ══════════════════════════════════════════════════════════════════════════
  Future<bool> verifyOtp({
    required String otp,
    required String deviceId,
    required String fcmToken,
  }) async {

    final double lat = LocationService.fetched ? LocationService.lt : 0.0;
    final double lng = LocationService.fetched ? LocationService.ln : 0.0;

    debugPrint('════════════════════════════════════════');
    debugPrint('[LOCATION] fetched : ${LocationService.fetched}');
    debugPrint('[LOCATION] lt      : ${LocationService.lt}');
    debugPrint('[LOCATION] ln      : ${LocationService.ln}');
    debugPrint('[LOCATION] error   : ${LocationService.error}');
    debugPrint('════════════════════════════════════════');

    if (_ledId == null) {
      _message = 'Session expired. Please login again.';
      debugPrint('[VERIFY OTP] ❌ _ledId is null');
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _message = '';

    final Map<String, String> body = {
      'type'     : '2',
      'led_id'   : _ledId.toString(),
      'otp'      : otp,
      'device_id': deviceId,
      'lt'       : lat.toString(),
      'ln'       : lng.toString(),
      'token'    : fcmToken,
    };

    debugPrint('════════════════════════════════════════');
    debugPrint('[VERIFY OTP] REQUEST');
    debugPrint('[VERIFY OTP] URL  : $_baseUrl');
    debugPrint('[VERIFY OTP] Body : $body');
    debugPrint('════════════════════════════════════════');

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      debugPrint('[VERIFY OTP] Status Code : ${response.statusCode}');
      debugPrint('[VERIFY OTP] Raw Body    : ${response.body}');

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint('[VERIFY OTP] Parsed JSON : $data');
      debugPrint('[VERIFY OTP] error       : ${data['error']}');
      debugPrint('[VERIFY OTP] error_msg   : ${data['error_msg']}');
      debugPrint('[VERIFY OTP] uid         : ${data['uid']}');
      debugPrint('[VERIFY OTP] role_id     : ${data['role_id']}');
      debugPrint('════════════════════════════════════════');

      if (response.statusCode == 200 && data['error'] == false) {
        final uid    = data['uid']     as int;
        final roleId = data['role_id'] as int? ?? 0;
        final mob    = data['mobile']  as String? ?? _mobile;

        await SharedPrefService.saveLoginData(
          userId   : uid,
          mobile   : mob,
          deviceId : deviceId,
          token    : fcmToken,
          type     : roleId.toString(),
          latitude : lat,
          longitude: lng,
        );

        debugPrint('════════════════════════════════════════');
        debugPrint('[SHARED PREFS] SAVED');
        debugPrint('[SHARED PREFS] userId   : $uid');
        debugPrint('[SHARED PREFS] mobile   : $mob');
        debugPrint('[SHARED PREFS] deviceId : $deviceId');
        debugPrint('[SHARED PREFS] type     : $roleId');
        debugPrint('[SHARED PREFS] latitude : $lat');
        debugPrint('[SHARED PREFS] longitude: $lng');
        debugPrint('════════════════════════════════════════');

        _message = data['error_msg'] ?? 'Login Successful';
        debugPrint('[VERIFY OTP] ✅ SUCCESS');
        _setLoading(false);
        return true;
      } else {
        _message = data['error_msg'] ?? 'Invalid OTP. Please try again.';
        debugPrint('[VERIFY OTP] ❌ FAILED — $_message');
        _setLoading(false);
        return false;
      }
    } catch (e, stack) {
      _message = 'Network error. Please check your connection.';
      debugPrint('[VERIFY OTP] ❌ EXCEPTION : $e');
      debugPrint('[VERIFY OTP] STACKTRACE  : $stack');
      _setLoading(false);
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  Logout
  // ══════════════════════════════════════════════════════════════════════════
  Future<void> logout() async {
    debugPrint('[LOGOUT] Clearing session...');
    await SharedPrefService.clearAll();
    LocationService.reset();
    _ledId   = 0;
    _mobile  = '';
    _message = '';
    debugPrint('[LOGOUT] ✅ Done');
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }
}