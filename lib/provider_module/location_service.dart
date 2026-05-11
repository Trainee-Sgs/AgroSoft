// ─────────────────────────────────────────────────────────────────────────────
//  location_service.dart
//  Static location cache — fetched ONCE in SplashScreen, read everywhere else.
//
//  pubspec.yaml dependencies:
//    geolocator: ^12.0.0
// ─────────────────────────────────────────────────────────────────────────────

import 'package:geolocator/geolocator.dart';

class LocationService {
  // ── Static cache ───────────────────────────────────────────────────────────
  static bool   fetched = false;
  static double lt      = 0.0;
  static double ln      = 0.0;
  static String error   = '';

  // ── Fetch once (call from SplashScreen only) ───────────────────────────────
  /// Named [init] so every caller (SplashScreen, OtpScreen) uses the same name.
  static Future<void> init() async {
    try {
      // 1. Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        error   = 'Location services disabled';
        fetched = false;
        return;
      }

      // 2. Check / request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        error   = 'Location permission denied';
        fetched = false;
        return;
      }

      // 3. Get position
      final Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 10));

      lt      = pos.latitude;
      ln      = pos.longitude;
      fetched = true;
      error   = '';
    } catch (e) {
      error   = e.toString();
      fetched = false;
    }
  }

  // ── Reset on logout ────────────────────────────────────────────────────────
  static void reset() {
    fetched = false;
    lt      = 0.0;
    ln      = 0.0;
    error   = '';
  }
}