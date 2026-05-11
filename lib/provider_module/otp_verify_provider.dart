// ─────────────────────────────────────────────────────────────────────────────
//  otp_verify_provider.dart
//  Single provider handling Login (type=1) + OTP Verify (type=2) + Logout.
//
//  Fixed:
//    • verifyOtp() no longer accepts latitude/longitude parameters —
//      it reads them from the LocationService static cache (set by the UI
//      before calling verifyOtp).
//
//  API payload for type=2:
//    type     : '2'
//    led_id   : from step-1 response
//    otp      : 6-digit user input
//    device_id: from device_info_plus
//    lt       : from LocationService cache
//    ln       : from LocationService cache
//    token    : from firebase_messaging
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'location_service.dart';
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

  static const String _baseUrl = 'https://agrosoftware.in/api/mobile/index.php';

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 1 — Login  (type=1 → sends OTP to mobile)
  // ══════════════════════════════════════════════════════════════════════════
  Future<bool> login({required String mobile}) async {
    _setLoading(true);
    _message = '';

    final Map<String, String> body = {
      'type'  : '1',
      'mobile': mobile,
    };

    debugPrint('════════════════════════════════════════');
    debugPrint('[LOGIN] REQUEST  → $_baseUrl/login');
    debugPrint('[LOGIN] Body     : $body');
    debugPrint('════════════════════════════════════════');

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint('[LOGIN] Status  : ${response.statusCode}');
      debugPrint('[LOGIN] Response: $data');

      if (response.statusCode == 200 && data['error'] == false) {
        _ledId   = data['led_id'] as int?;
        _mobile  = mobile;
        _message = data['error_msg'] ?? 'OTP sent successfully';
        debugPrint('[LOGIN] ✅ led_id=$_ledId  mobile=$_mobile');
        _setLoading(false);
        return true;
      } else {
        _message = data['error_msg'] ?? 'Login failed. Please try again.';
        debugPrint('[LOGIN] ❌ $_message');
        _setLoading(false);
        return false;
      }
    } catch (e, st) {
      _message = 'Network error. Please check your connection.';
      debugPrint('[LOGIN] ❌ EXCEPTION: $e\n$st');
      _setLoading(false);
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 2 — Verify OTP  (type=2)
  //
  //  The UI must update LocationService.lt / .ln / .fetched before calling
  //  this method so the latest coords are sent with the request.
  //
  //  Payload:
  //    type=2 | led_id | otp | device_id | lt | ln | token
  // ══════════════════════════════════════════════════════════════════════════
  Future<bool> verifyOtp({
    required String otp,
    required String deviceId,
    required String fcmToken,
  }) async {

    // Guard: led_id must exist from step-1
    if (_ledId == null) {
      _message = 'Session expired. Please login again.';
      debugPrint('[VERIFY OTP] ❌ _ledId is null');
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _message = '';

    // ── Read lat/lng from static LocationService cache ─────────────────────
    // The OtpScreen._verify() method updates this cache with a fresh position
    // before calling verifyOtp(), so these values are always up to date.
    final double lat = LocationService.fetched ? LocationService.lt : 0.0;
    final double lng = LocationService.fetched ? LocationService.ln : 0.0;

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
    debugPrint('[VERIFY OTP] REQUEST  → $_baseUrl/login');
    debugPrint('[VERIFY OTP] Body     : $body');
    debugPrint('[LOCATION]   fetched=${LocationService.fetched}  lt=$lat  ln=$lng');
    debugPrint('════════════════════════════════════════');

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      debugPrint('[VERIFY OTP] Status  : ${response.statusCode}');
      debugPrint('[VERIFY OTP] Response: $data');

      if (response.statusCode == 200 && data['error'] == false) {
        final uid    = data['uid']      as int;
        final roleId = (data['role_id'] as int?)    ?? 0;
        final mob    = (data['mobile']  as String?) ?? _mobile;

        // ── Persist everything to SharedPreferences ────────────────────────
        await SharedPrefService.saveLoginData(
          userId   : uid,
          mobile   : mob,
          deviceId : deviceId,
          token    : fcmToken,
          type     : roleId.toString(),
          ledId    : _ledId!,
          latitude : lat,
          longitude: lng,
        );

        debugPrint('════════════════════════════════════════');
        debugPrint('[SHARED PREFS] SAVED');
        debugPrint('  userId   : $uid');
        debugPrint('  mobile   : $mob');
        debugPrint('  deviceId : $deviceId');
        debugPrint('  token    : $fcmToken');
        debugPrint('  type     : $roleId');
        debugPrint('  led_id   : $_ledId');
        debugPrint('  latitude : $lat');
        debugPrint('  longitude: $lng');

        // ── Read-back verification ─────────────────────────────────────────
        final savedUserId   = await SharedPrefService.getUserId();
        final savedMobile   = await SharedPrefService.getMobile();
        final savedDeviceId = await SharedPrefService.getDeviceId();
        final savedLedId    = await SharedPrefService.getLedId();
        final isLoggedIn    = await SharedPrefService.isLoggedIn();
        debugPrint('[SHARED PREFS] READ-BACK');
        debugPrint('  isLoggedIn  : $isLoggedIn');
        debugPrint('  userId      : $savedUserId');
        debugPrint('  mobile      : $savedMobile');
        debugPrint('  deviceId    : $savedDeviceId');
        debugPrint('  led_id      : $savedLedId');
        debugPrint('════════════════════════════════════════');

        _message = data['error_msg'] ?? 'Login Successful';
        _setLoading(false);
        return true;

      } else {
        _message = data['error_msg'] ?? 'Invalid OTP. Please try again.';
        debugPrint('[VERIFY OTP] ❌ $_message');
        _setLoading(false);
        return false;
      }
    } catch (e, st) {
      _message = 'Network error. Please check your connection.';
      debugPrint('[VERIFY OTP] ❌ EXCEPTION: $e\n$st');
      _setLoading(false);
      return false;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  Logout
  // ══════════════════════════════════════════════════════════════════════════
  Future<void> logout() async {
    debugPrint('[LOGOUT] Clearing SharedPreferences & LocationService cache');
    await SharedPrefService.clearAll();
    LocationService.reset();
    _ledId   = null;
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