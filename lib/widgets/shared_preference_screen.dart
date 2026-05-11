// ─────────────────────────────────────────────────────────────────────────────
//  shared_pref_service.dart
//  Thin wrapper around SharedPreferences.
//  Stores / retrieves all login-related data in one place.
//
//  pubspec.yaml dependency:
//    shared_preferences: ^2.3.2
// ─────────────────────────────────────────────────────────────────────────────

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  // ── Keys ───────────────────────────────────────────────────────────────────
  static const String _kUserId   = 'user_id';
  static const String _kMobile   = 'mobile';
  static const String _kDeviceId = 'device_id';
  static const String _kToken    = 'fcm_token';
  static const String _kType     = 'user_type';
  static const String _kIsLogged = 'is_logged_in';
  static const String _kLat      = 'latitude';
  static const String _kLng      = 'longitude';
  static const String _kLedId    = 'led_id';

  // ── Save after successful login / OTP verify ───────────────────────────────
  /// [ledId] defaults to 0 — pass the real value only after OTP verify (step 2).
  static Future<void> saveLoginData({
    required int    userId,
    required String mobile,
    required String deviceId,
    required String token,
    required String type,
    int    ledId    = 0,       // ← optional; 0 is fine for step-1 (mobile login)
    double latitude  = 0.0,
    double longitude = 0.0,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(   _kUserId,   userId);
    await prefs.setString(_kMobile,   mobile);
    await prefs.setString(_kDeviceId, deviceId);
    await prefs.setString(_kToken,    token);
    await prefs.setString(_kType,     type);
    await prefs.setDouble(_kLat,      latitude);
    await prefs.setDouble(_kLng,      longitude);
    await prefs.setInt(   _kLedId,    ledId);
    await prefs.setBool(  _kIsLogged, true);
  }

  // ── Individual getters ─────────────────────────────────────────────────────
  static Future<int?>    getUserId()    async => (await SharedPreferences.getInstance()).getInt(_kUserId);
  static Future<String?> getMobile()    async => (await SharedPreferences.getInstance()).getString(_kMobile);
  static Future<String?> getDeviceId()  async => (await SharedPreferences.getInstance()).getString(_kDeviceId);
  static Future<String?> getToken()     async => (await SharedPreferences.getInstance()).getString(_kToken);
  static Future<String?> getType()      async => (await SharedPreferences.getInstance()).getString(_kType);
  static Future<int?>    getLedId()     async => (await SharedPreferences.getInstance()).getInt(_kLedId);
  static Future<double>  getLatitude()  async => (await SharedPreferences.getInstance()).getDouble(_kLat)  ?? 0.0;
  static Future<double>  getLongitude() async => (await SharedPreferences.getInstance()).getDouble(_kLng) ?? 0.0;

  // ── Login state ────────────────────────────────────────────────────────────
  static Future<bool> isLoggedIn() async =>
      (await SharedPreferences.getInstance()).getBool(_kIsLogged) ?? false;

  // ── Update location only (e.g. on each app open) ──────────────────────────
  static Future<void> updateLocation(double lat, double lng) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kLat, lat);
    await prefs.setDouble(_kLng, lng);
  }

  // ── Logout — clears all stored data ───────────────────────────────────────
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}