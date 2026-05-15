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

  static const String _baseUrl = 'https://agrosoftware.in/api/mobile/index_new.php';

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // ══════════════════════════════════════════════════════════════════════════
  //  STEP 1 — Login  (type=86 → sends OTP to mobile)
  // ══════════════════════════════════════════════════════════════════════════
  Future<bool> login({
    required String mobile,
    required String deviceId,
    double latitude  = 0.0,
    double longitude = 0.0,
    String token     = '',
  }) async {
    _setLoading(true);
    _message = '';

    // Fetch and validate cid/uid from storage
    int? savedCid = await SharedPrefService.getLedId();
    int? savedUid = await SharedPrefService.getUserId();

    // ── FORCE OVERRIDE OLD PLACEHOLDERS ────────────────────────────────
    if (savedCid == null || savedCid == 456 || savedCid == 0) {
      savedCid = 49542621;
    }
    if (savedUid == null || savedUid == 789 || savedUid == 0) {
      savedUid = 2;
    }

    final Map<String, String> body = {
      'type'     : '86',
      'device_id': deviceId,
      'mobile'   : mobile,
      'lt'       : latitude.toString(),
      'ln'       : longitude.toString(),
      'token'    : token,
      'cid'      : savedCid.toString(),
      'uid'      : savedUid.toString(),
    };

    debugPrint('════════════════════════════════════════');
    debugPrint('[LOGIN] REQUEST  → $_baseUrl');
    debugPrint('[LOGIN] Body     : $body');
    debugPrint('════════════════════════════════════════');

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      debugPrint('[LOGIN] Status  : ${response.statusCode}');
      
      if (response.body.trim().isEmpty) {
        _message = 'Server returned an empty response. OTP not sent.';
        debugPrint('[LOGIN] ❌ Empty body from server');
        _setLoading(false);
        return false;
      }

      final Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        _message = 'Invalid server response. Check terminal for details.';
        debugPrint('[LOGIN] ❌ JSON DECODE ERROR: $e');
        debugPrint('[LOGIN] ❌ RAW BODY: ${response.body}');
        _setLoading(false);
        return false;
      }

      debugPrint('[LOGIN] Response: $data');

      if (response.statusCode == 200 && data['error'] == false) {
        _ledId   = data['id'] as int?; 
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
  //  STEP 2 — Verify OTP  (type=87)
  // ══════════════════════════════════════════════════════════════════════════
  Future<bool> verifyOtp({
    required String otp,
    required String deviceId,
    required String fcmToken,
  }) async {

    if (_ledId == null) {
      _message = 'Session expired. Please login again.';
      debugPrint('[VERIFY OTP] ❌ _ledId is null');
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _message = '';

    final double lat = LocationService.fetched ? LocationService.lt : 0.0;
    final double lng = LocationService.fetched ? LocationService.ln : 0.0;

    // Fetch and validate cid/uid from storage (as mentioned they are fetched in Splash)
    int? savedCid = await SharedPrefService.getLedId();
    int? savedUid = await SharedPrefService.getUserId();

    // ── FORCE OVERRIDE OLD PLACEHOLDERS ────────────────────────────────
    if (savedCid == null || savedCid == 456 || savedCid == 0) {
      savedCid = 49542621;
    }
    if (savedUid == null || savedUid == 789 || savedUid == 0) {
      savedUid = 2;
    }

    final Map<String, String> body = {
      'type'     : '87',
      'led_id'   : _ledId.toString(),
      'cid'      : savedCid.toString(),
      'device_id': deviceId,
      'lt'       : lat.toString(),
      'ln'       : lng.toString(),
      'uid'      : savedUid.toString(),
      'otp'      : otp,
      'token'    : fcmToken,
    };

    debugPrint('════════════════════════════════════════');
    debugPrint('[VERIFY OTP] REQUEST  → $_baseUrl');
    debugPrint('[VERIFY OTP] Body     : $body');
    debugPrint('════════════════════════════════════════');

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      ).timeout(const Duration(seconds: 15));

      debugPrint('[VERIFY OTP] Status  : ${response.statusCode}');
      
      if (response.body.trim().isEmpty) {
        _message = 'Server returned an empty response.';
        debugPrint('[VERIFY OTP] ❌ Empty body from server');
        _setLoading(false);
        return false;
      }

      final Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        _message = 'Invalid server response. Check terminal for details.';
        debugPrint('[VERIFY OTP] ❌ JSON DECODE ERROR: $e');
        debugPrint('[VERIFY OTP] ❌ RAW BODY: ${response.body}');
        _setLoading(false);
        return false;
      }

      debugPrint('[VERIFY OTP] Response: $data');

      if (response.statusCode == 200 && data['error'] == false) {
        final uid    = data['uid']      as int;
        final cid    = data['cid']      as int;
        final roleId = (data['role_id'] as int?)    ?? 0;
        final mob    = (data['mobile']  as String?) ?? _mobile;

        // ── Persist everything to SharedPreferences ────────────────────────
        await SharedPrefService.saveLoginData(
          userId   : uid,
          mobile   : mob,
          deviceId : deviceId,
          token    : fcmToken,
          type     : roleId.toString(),
          ledId    : cid, // Using cid from response as the primary ledger ID
          latitude : lat,
          longitude: lng,
        );

        // Debug Print updated SharedPreferences
        await SharedPrefService.debugPrintAll();

        // Optionally store company info (com) if needed by other screens
        // For now, we just proceed as the user asked for "binding"
        
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
}