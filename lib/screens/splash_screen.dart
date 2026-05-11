// ─────────────────────────────────────────────────────────────────────────────
//  splash_screen.dart
//  Fixed:
//    • LocationService.init() now exists (was fetchOnce() in original).
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import '../provider_module/location_service.dart';
import '../screens/login_screen.dart';

// ══════════════════════════════════════════════════════════════════════════════
//  SPLASH SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  // ── Animation controllers ──────────────────────────────────────────────────
  late AnimationController _ringCtrl;
  late AnimationController _fadeCtrl;
  late AnimationController _leafCtrl;
  late Animation<double>   _ringScale;
  late Animation<double>   _logoFade;
  late Animation<double>   _logoSlide;
  late Animation<double>   _taglineFade;
  late Animation<double>   _leafRot;

  // ── Location state ─────────────────────────────────────────────────────────
  _LocationState _locState = _LocationState.fetching;
  String         _locText  = 'Fetching location…';

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:          Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    // ── Set up animations ──────────────────────────────────────────────────
    _ringCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _leafCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat();

    _ringScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _ringCtrl, curve: Curves.elasticOut));

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _fadeCtrl,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));

    _logoSlide = Tween<double>(begin: 40.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _fadeCtrl,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));

    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _fadeCtrl,
            curve: const Interval(0.5, 1.0, curve: Curves.easeIn)));

    _leafRot = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
        CurvedAnimation(parent: _leafCtrl, curve: Curves.linear));

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _ringCtrl.forward();
        _fadeCtrl.forward();
      }
    });

    // ── Run location fetch + minimum splash timer in parallel ──────────────
    _startSplash();
  }

  // ── Core splash logic ──────────────────────────────────────────────────────
  Future<void> _startSplash() async {
    await Future.wait([
      _handleLocationPermission(),
      Future.delayed(const Duration(milliseconds: 3200)),
    ]);

    // Wait until location resolves (in case permission dialog took time)
    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      return _locState == _LocationState.fetching;
    });

    _navigate();
  }

  // ── STEP 1+2: Check GPS service, then permission ───────────────────────────
  Future<void> _handleLocationPermission() async {
    if (!mounted) return;

    // ── STEP 1: Check if GPS/Location service is ON ────────────────────────
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      await _showLocationServiceDialog();
      // After user returns from settings or taps Skip, check again
      final enabledNow = await Geolocator.isLocationServiceEnabled();
      if (!enabledNow) {
        _setLocationFailed('Location service is off');
        return;
      }
      // GPS turned on — fall through to permission check below
    }

    // ── STEP 2: Check permission ───────────────────────────────────────────
    final status = await Permission.location.status;

    if (status.isGranted) {
      await _fetchLocation();
      return;
    }

    if (status.isPermanentlyDenied) {
      if (!mounted) return;
      await _showPermissionDialog(permanentlyDenied: true);
      final newStatus = await Permission.location.status;
      if (newStatus.isGranted) {
        await _fetchLocation();
      } else {
        _setLocationFailed('Location permission denied');
      }
      return;
    }

    // Not yet asked — show rationale dialog first, then request
    if (!mounted) return;
    await _showPermissionDialog(permanentlyDenied: false);
    // _fetchLocation() is called inside the Allow button callback
  }

  // ── Dialog: GPS/Location service is OFF ───────────────────────────────────
  Future<void> _showLocationServiceDialog() async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 68, height: 68,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF1B8A3E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.gps_off_rounded,
                    color: Colors.white, size: 34),
              ),
              const SizedBox(height: 20),
              const Text(
                'Turn On Location',
                style: TextStyle(
                  color: Color(0xFF1A2E1A),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your device\'s location (GPS) is turned off. '
                    'Please enable it so AgroSoft can fetch your coordinates.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5A7260),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF5A7260),
                      side: const BorderSide(color: Color(0xFFD0E8D4)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: const Text('Skip',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(ctx);
                      await Geolocator.openLocationSettings();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B8A3E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    child: const Text('Enable GPS',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 13)),
                  ),
                ),
              ]),
              const SizedBox(height: 4),
              Text(
                'You can change this later in Settings',
                style: TextStyle(
                  color: const Color(0xFF9DB89E).withOpacity(0.85),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Dialog: Permission denied / not yet asked ──────────────────────────────
  Future<void> _showPermissionDialog({required bool permanentlyDenied}) async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 68, height: 68,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF1B8A3E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(
                  permanentlyDenied
                      ? Icons.location_off_rounded
                      : Icons.location_on_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                permanentlyDenied ? 'Location Blocked' : 'Location Access',
                style: const TextStyle(
                  color: Color(0xFF1A2E1A),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                permanentlyDenied
                    ? 'Location permission is blocked. Please enable it from app settings to continue.'
                    : 'AgroSoft needs your location to provide accurate farming recommendations.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF5A7260),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              if (permanentlyDenied) ...[
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5A7260),
                        side: const BorderSide(color: Color(0xFFD0E8D4)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text('Skip',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(ctx);
                        await openAppSettings();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B8A3E),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text('Open Settings',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 13)),
                    ),
                  ),
                ]),
              ] else ...[
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(ctx);
                        await Future.delayed(
                            const Duration(milliseconds: 50));
                        _setLocationFailed('Location skipped');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5A7260),
                        side: const BorderSide(color: Color(0xFFD0E8D4)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text('Not Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 13)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(ctx);
                        final result = await Permission.location.request();
                        if (!mounted) return;
                        if (result.isGranted) {
                          await _fetchLocation();
                        } else if (result.isPermanentlyDenied) {
                          _setLocationFailed('Permission permanently denied');
                        } else {
                          _setLocationFailed('Permission denied');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B8A3E),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                      ),
                      child: const Text('Allow',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 13)),
                    ),
                  ),
                ]),
              ],
              const SizedBox(height: 4),
              Text(
                'You can change this later in Settings',
                style: TextStyle(
                  color: const Color(0xFF9DB89E).withOpacity(0.85),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setLocationFailed(String msg) {
    if (!mounted) return;
    setState(() {
      _locState = _LocationState.failed;
      _locText  = msg;
    });
  }

  // ── Fetch GPS after permission granted ─────────────────────────────────────
  Future<void> _fetchLocation() async {
    if (!mounted) return;
    setState(() {
      _locState = _LocationState.fetching;
      _locText  = 'Fetching location…';
    });

    // ✅ Calls LocationService.init() — renamed from fetchOnce()
    await LocationService.init();

    if (!mounted) return;
    setState(() {
      if (LocationService.fetched) {
        _locState = _LocationState.success;
        _locText  =
        '${LocationService.lt.toStringAsFixed(4)}, '
            '${LocationService.ln.toStringAsFixed(4)}';
      } else {
        _locState = _LocationState.failed;
        _locText  = LocationService.error.isNotEmpty
            ? LocationService.error
            : 'Location unavailable';
      }
    });
  }

  void _navigate() {
    if (!mounted) return;
    Navigator.pushReplacement(context, _fadeRoute(const LoginScreen()));
  }

  @override
  void dispose() {
    _ringCtrl.dispose();
    _fadeCtrl.dispose();
    _leafCtrl.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _C.splashBg,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MeshPainter())),
          ...List.generate(6, (i) => _FloatingLeaf(index: i, rot: _leafRot)),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: ClipPath(
              clipper: _WaveClipper(),
              child: Container(
                height: size.height * 0.28,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1B8A3E), Color(0xFF0D5C28)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _ringScale,
              builder: (_, __) => Stack(
                alignment: Alignment.center,
                children: [
                  Transform.scale(
                    scale: _ringScale.value,
                    child: Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _C.accent.withOpacity(0.15), width: 40),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _ringScale.value * 0.82,
                    child: Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: _C.accent.withOpacity(0.25), width: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _fadeCtrl,
              builder: (_, __) => Opacity(
                opacity: _logoFade.value,
                child: Transform.translate(
                  offset: Offset(0, _logoSlide.value),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 110, height: 110,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF1B8A3E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: _C.accent.withOpacity(0.5),
                              blurRadius: 40,
                              spreadRadius: 4,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.eco_rounded,
                                color: Colors.white, size: 54),
                            Positioned(
                              top: 14, right: 14,
                              child: Container(
                                width: 10, height: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                            text: 'Agro',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                          TextSpan(
                            text: 'Soft',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      AnimatedBuilder(
                        animation: _taglineFade,
                        builder: (_, __) => Opacity(
                          opacity: _taglineFade.value,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                      width: 28,
                                      height: 1.5,
                                      color: _C.accentLt.withOpacity(0.6)),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Smart Farming Solutions',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.4,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                      width: 28,
                                      height: 1.5,
                                      color: _C.accentLt.withOpacity(0.6)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _LocationChip(state: _locState, text: _locText),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 36, left: 0, right: 0,
            child: AnimatedBuilder(
              animation: _taglineFade,
              builder: (_, __) => Opacity(
                opacity: _taglineFade.value,
                child: const Column(
                  children: [
                    _LoadingDots(),
                    SizedBox(height: 10),
                    Text(
                      'v1.0.0',
                      style: TextStyle(
                        color: Color(0x59FFFFFF),
                        fontSize: 11,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  LOCATION CHIP
// ══════════════════════════════════════════════════════════════════════════════
enum _LocationState { fetching, success, failed }

class _LocationChip extends StatelessWidget {
  final _LocationState state;
  final String         text;
  const _LocationChip({required this.state, required this.text});

  @override
  Widget build(BuildContext context) {
    final Color    chipColor;
    final Color    borderColor;
    final Color    iconColor;
    final Color    textColor;
    final IconData icon;

    switch (state) {
      case _LocationState.fetching:
        chipColor   = Colors.white.withOpacity(0.08);
        borderColor = Colors.white.withOpacity(0.15);
        iconColor   = Colors.white.withOpacity(0.5);
        textColor   = Colors.white.withOpacity(0.45);
        icon        = Icons.location_searching_rounded;
        break;
      case _LocationState.success:
        chipColor   = const Color(0xFF4CAF50).withOpacity(0.18);
        borderColor = const Color(0xFF4CAF50).withOpacity(0.4);
        iconColor   = const Color(0xFF4CAF50);
        textColor   = Colors.white.withOpacity(0.85);
        icon        = Icons.location_on_rounded;
        break;
      case _LocationState.failed:
        chipColor   = Colors.red.withOpacity(0.12);
        borderColor = Colors.red.withOpacity(0.3);
        iconColor   = Colors.red.withOpacity(0.7);
        textColor   = Colors.white.withOpacity(0.5);
        icon        = Icons.location_off_rounded;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          state == _LocationState.fetching
              ? SizedBox(
            width: 13, height: 13,
            child: CircularProgressIndicator(
              strokeWidth: 1.5,
              color: Colors.white.withOpacity(0.5),
            ),
          )
              : Icon(icon, color: iconColor, size: 13),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: 10,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  COLOUR PALETTE
// ══════════════════════════════════════════════════════════════════════════════
class _C {
  static const bg       = Color(0xFFF2F7F2);
  static const primary  = Color(0xFF1B8A3E);
  static const accent   = Color(0xFF4CAF50);
  static const accentLt = Color(0xFFA5D6A7);
  static const splashBg = Color(0xFF0D4A1F);
}

// ══════════════════════════════════════════════════════════════════════════════
//  HELPERS
// ══════════════════════════════════════════════════════════════════════════════
class _LoadingDots extends StatefulWidget {
  const _LoadingDots();
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _ctrl,
    builder: (_, __) => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final t     = (_ctrl.value - i * 0.15).clamp(0.0, 1.0);
        final scale = math.sin(t * math.pi).clamp(0.0, 1.0);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 7, height: 7,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3 + 0.7 * scale),
            shape: BoxShape.circle,
          ),
        );
      }),
    ),
  );
}

class _FloatingLeaf extends StatelessWidget {
  final int               index;
  final Animation<double> rot;
  const _FloatingLeaf({required this.index, required this.rot});

  @override
  Widget build(BuildContext context) {
    final size      = MediaQuery.of(context).size;
    final offsets   = [
      Offset(size.width * 0.08, size.height * 0.15),
      Offset(size.width * 0.82, size.height * 0.10),
      Offset(size.width * 0.05, size.height * 0.65),
      Offset(size.width * 0.88, size.height * 0.55),
      Offset(size.width * 0.25, size.height * 0.85),
      Offset(size.width * 0.72, size.height * 0.80),
    ];
    final sizes     = [18.0, 24.0, 14.0, 22.0, 16.0, 20.0];
    final opacities = [0.12, 0.08, 0.15, 0.10, 0.13, 0.09];
    final speeds    = [1.0,  0.7,  1.3,  0.9,  1.1,  0.8];

    return Positioned(
      left: offsets[index].dx,
      top:  offsets[index].dy,
      child: AnimatedBuilder(
        animation: rot,
        builder: (_, __) => Transform.rotate(
          angle: rot.value * speeds[index],
          child: Icon(Icons.eco_rounded,
              color: _C.accent.withOpacity(opacities[index]),
              size:  sizes[index]),
        ),
      ),
    );
  }
}

class _MeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = const Color(0xFF0A3D18);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    paint.color = const Color(0xFF1B6B30).withOpacity(0.35);
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.35);
    path.cubicTo(size.width * 0.25, 0, size.width * 0.75,
        size.height * 0.5, size.width, size.height * 0.2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

PageRoute _fadeRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, a, __) =>
      FadeTransition(opacity: a, child: page),
  transitionDuration: const Duration(milliseconds: 600),
);