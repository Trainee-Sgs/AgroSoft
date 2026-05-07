import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  COLOUR PALETTE
// ─────────────────────────────────────────────────────────────────────────────
class _C {
  static const bg         = Color(0xFFF2F7F2);
  static const surface    = Colors.white;
  static const primary    = Color(0xFF1B8A3E);
  static const primaryDk  = Color(0xFF136B2F);
  static const primaryLt  = Color(0xFFE6F4EC);
  static const accent     = Color(0xFF4CAF50);
  static const accentLt   = Color(0xFFA5D6A7);
  static const gold       = Color(0xFFF9A825);
  static const textDark   = Color(0xFF1A2E1A);
  static const textMid    = Color(0xFF5A7260);
  static const textLight  = Color(0xFF9DB89E);
  static const border     = Color(0xFFD0E8D4);
  static const red        = Color(0xFFE53935);
  static const splashBg   = Color(0xFF0D4A1F);
}

// ══════════════════════════════════════════════════════════════════════════════
//  1.  SPLASH SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _ringCtrl;
  late AnimationController _fadeCtrl;
  late AnimationController _leafCtrl;
  late Animation<double>   _ringScale;
  late Animation<double>   _logoFade;
  late Animation<double>   _logoSlide;
  late Animation<double>   _taglineFade;
  late Animation<double>   _leafRot;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    _ringCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _leafCtrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 6))
      ..repeat();

    _ringScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _ringCtrl, curve: Curves.elasticOut));
    _logoFade  = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _fadeCtrl,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));
    _logoSlide = Tween<double>(begin: 40.0, end: 0.0).animate(
        CurvedAnimation(parent: _fadeCtrl,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));
    _taglineFade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _fadeCtrl,
            curve: const Interval(0.5, 1.0, curve: Curves.easeIn)));
    _leafRot = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
        CurvedAnimation(parent: _leafCtrl, curve: Curves.linear));

    Future.delayed(const Duration(milliseconds: 200), () {
      _ringCtrl.forward();
      _fadeCtrl.forward();
    });

    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.pushReplacement(context, _fadeRoute(const LoginScreen()));
      }
    });
  }

  @override
  void dispose() {
    _ringCtrl.dispose();
    _fadeCtrl.dispose();
    _leafCtrl.dispose();
    super.dispose();
  }

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
                        text: const TextSpan(
                          children: [
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      AnimatedBuilder(
                        animation: _taglineFade,
                        builder: (_, __) => Opacity(
                          opacity: _taglineFade.value,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  width: 28, height: 1.5,
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
                                  width: 28, height: 1.5,
                                  color: _C.accentLt.withOpacity(0.6)),
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
                child: Column(
                  children: [
                    const _LoadingDots(),
                    const SizedBox(height: 10),
                    Text(
                      'v1.0.0',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.35),
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
//  2.  LOGIN SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final _phoneCtrl = TextEditingController();
  bool  _loading   = false;
  late AnimationController _animCtrl;
  late Animation<double>   _slideAnim;
  late Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _slideAnim = Tween<double>(begin: 60, end: 0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _fadeAnim  = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _proceed() async {
    if (_phoneCtrl.text.trim().length != 10) {
      _shake();
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.push(context, _slideRoute(
      OtpScreen(phone: _phoneCtrl.text.trim()),
    ));
  }

  void _shake() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Enter a valid 10-digit mobile number'),
      backgroundColor: _C.red,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  // ── NEW: request location permission then navigate to RegisterScreen ────────
  Future<void> _requestLocationAndNavigate() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      // Already granted → go directly
      if (!mounted) return;
      Navigator.push(context, _slideRoute(const RegisterScreen()));
      return;
    }

    if (status.isPermanentlyDenied) {
      // User permanently denied → show dialog to open settings
      if (!mounted) return;
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.location_off_rounded, color: _C.red),
              SizedBox(width: 10),
              Text('Location Blocked',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800)),
            ],
          ),
          content: const Text(
            'Location permission is permanently denied. '
                'Please enable it from App Settings to continue.',
            style: TextStyle(fontSize: 13, color: _C.textMid),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: _C.textMid)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
              child: const Text('Open Settings',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
      return;
    }

    // Show rationale dialog before requesting
    if (!mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.location_on_rounded, color: _C.primary),
            SizedBox(width: 10),
            Text('Location Access',
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w800)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _C.primaryLt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: _C.primary, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AgroSoft uses your location to provide '
                          'region-specific farming data and services.',
                      style: TextStyle(
                          fontSize: 12,
                          color: _C.textMid,
                          height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please allow location access to register.',
              style: TextStyle(
                  fontSize: 13, color: _C.textDark,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Not Now',
                style: TextStyle(color: _C.textMid)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _C.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () async {
              Navigator.pop(context);
              final result = await Permission.location.request();
              if (!mounted) return;
              if (result.isGranted) {
                Navigator.push(
                    context, _slideRoute(const RegisterScreen()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Row(children: [
                    Icon(Icons.location_off_rounded,
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text('Location permission denied'),
                  ]),
                  backgroundColor: _C.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ));
              }
            },
            child: const Text('Allow',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _C.splashBg,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MeshPainter())),
          Positioned(
            top: -60, left: size.width * 0.5 - 160,
            child: Container(
              width: 320, height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _C.accent.withOpacity(0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    Container(
                      width: 72, height: 72,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF1B8A3E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _C.accent.withOpacity(0.45),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.eco_rounded,
                          color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 14),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(text: 'Agro',
                            style: TextStyle(color: Colors.white,
                                fontSize: 26, fontWeight: FontWeight.w900,
                                letterSpacing: -0.5)),
                        TextSpan(text: 'Soft',
                            style: TextStyle(color: Color(0xFF4CAF50),
                                fontSize: 26, fontWeight: FontWeight.w900,
                                letterSpacing: -0.5)),
                      ]),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _animCtrl,
                      builder: (_, child) => Opacity(
                        opacity: _fadeAnim.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideAnim.value),
                          child: child,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                        decoration: BoxDecoration(
                          color: _C.surface,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 48,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: _C.primaryLt,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(Icons.waving_hand_rounded,
                                      color: _C.primary, size: 22),
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Welcome Back!',
                                        style: TextStyle(
                                            color: _C.textDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800)),
                                    Text('Sign in to continue',
                                        style: TextStyle(
                                            color: _C.textMid.withOpacity(0.8),
                                            fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),
                            const Text('Mobile Number',
                                style: TextStyle(
                                    color: _C.textMid,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.4)),
                            const SizedBox(height: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: _C.bg,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: _C.border),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: _C.primaryLt,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16),
                                      ),
                                    ),
                                    child: const Row(
                                      children: [
                                        Text('🇮🇳',
                                            style: TextStyle(fontSize: 18)),
                                        SizedBox(width: 6),
                                        Text('+91',
                                            style: TextStyle(
                                                color: _C.primary,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Container(width: 1, height: 28, color: _C.border),
                                  Expanded(
                                    child: TextField(
                                      controller: _phoneCtrl,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 10,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: const TextStyle(
                                          color: _C.textDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        hintText: '00000 00000',
                                        hintStyle: TextStyle(
                                            color: _C.textLight,
                                            fontSize: 15,
                                            letterSpacing: 2,
                                            fontWeight: FontWeight.w500),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('  We\'ll send a 4-digit OTP to verify',
                                style: TextStyle(
                                    color: _C.textLight,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 28),
                            _GreenButton(
                              label: 'GET OTP',
                              icon: Icons.arrow_forward_rounded,
                              loading: _loading,
                              onTap: _proceed,
                            ),
                            const SizedBox(height: 20),

                            // ── UPDATED: "Register Here" now requests location ──
                            Center(
                              child: GestureDetector(
                                onTap: _requestLocationAndNavigate, // ← changed
                                child: RichText(
                                  text: const TextSpan(children: [
                                    TextSpan(
                                      text: 'New user? ',
                                      style: TextStyle(
                                          color: _C.textMid, fontSize: 13),
                                    ),
                                    TextSpan(
                                      text: 'Register Here',
                                      style: TextStyle(
                                          color: _C.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      '© 2025 AgroSoft. All rights reserved.',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.25),
                          fontSize: 11),
                    ),
                    const SizedBox(height: 16),
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
//  3.  OTP SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {

  final List<TextEditingController> _ctls =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _loading    = false;
  int  _resendSecs = 30;
  bool _canResend  = false;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<double>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim  = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn));
    _slideAnim = Tween<double>(begin: 50, end: 0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
    _startResendTimer();
  }

  void _startResendTimer() async {
    for (int i = _resendSecs; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        _resendSecs = i;
        if (i == 0) _canResend = true;
      });
    }
  }

  @override
  void dispose() {
    for (final c in _ctls) c.dispose();
    for (final f in _focusNodes) f.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  String get _otp => _ctls.map((c) => c.text).join();

  void _verify() async {
    if (_otp.length < 4) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Enter the 4-digit OTP'),
        backgroundColor: _C.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushAndRemoveUntil(
      context,
      _fadeRoute(const DashboardScreen()),
          (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [
        Icon(Icons.check_circle_rounded, color: Colors.white),
        SizedBox(width: 10),
        Text('OTP Verified!'),
      ]),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final masked = '+91 ${widget.phone.substring(0, 5)}*****';
    return Scaffold(
      backgroundColor: _C.splashBg,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MeshPainter())),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white, size: 20),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Spacer(),
                          const Text('AgroSoft',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      width: 90, height: 90,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF1B8A3E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: _C.accent.withOpacity(0.45),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.verified_rounded,
                          color: Colors.white, size: 46),
                    ),
                    const SizedBox(height: 18),
                    const Text('OTP Verification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5)),
                    const SizedBox(height: 8),
                    Text(
                      'Sent to $masked',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _animCtrl,
                      builder: (_, child) => Opacity(
                        opacity: _fadeAnim.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideAnim.value),
                          child: child,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: _C.surface,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 48,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text('Enter 4-Digit OTP',
                                style: TextStyle(
                                    color: _C.textDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4, (i) => _OtpBox(
                                controller: _ctls[i],
                                focusNode: _focusNodes[i],
                                onChanged: (val) {
                                  if (val.isNotEmpty && i < 3) {
                                    _focusNodes[i + 1].requestFocus();
                                  }
                                  if (val.isEmpty && i > 0) {
                                    _focusNodes[i - 1].requestFocus();
                                  }
                                  setState(() {});
                                },
                              )),
                            ),
                            const SizedBox(height: 28),
                            _GreenButton(
                              label: 'VERIFY OTP',
                              icon: Icons.shield_rounded,
                              loading: _loading,
                              onTap: _verify,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Didn\'t receive? ',
                                    style: TextStyle(
                                        color: _C.textMid, fontSize: 13)),
                                GestureDetector(
                                  onTap: _canResend ? () {
                                    setState(() {
                                      _canResend  = false;
                                      _resendSecs = 30;
                                    });
                                    _startResendTimer();
                                  } : null,
                                  child: Text(
                                    _canResend
                                        ? 'Resend OTP'
                                        : 'Resend in ${_resendSecs}s',
                                    style: TextStyle(
                                      color: _canResend
                                          ? _C.primary : _C.textLight,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
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
//  4.  REGISTER SCREEN  (unchanged)
// ══════════════════════════════════════════════════════════════════════════════
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {

  final _companyCtrl     = TextEditingController();
  final _proprietorCtrl  = TextEditingController();
  final _mobileCtrl      = TextEditingController();
  final _addressCtrl     = TextEditingController();
  final _gstCtrl         = TextEditingController();
  final _panCtrl         = TextEditingController();
  final _aadharCtrl      = TextEditingController();
  bool _loading          = false;
  bool _agreed           = false;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<double>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim  = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn));
    _slideAnim = Tween<double>(begin: 60, end: 0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _companyCtrl.dispose(); _proprietorCtrl.dispose();
    _mobileCtrl.dispose();  _addressCtrl.dispose();
    _gstCtrl.dispose();     _panCtrl.dispose();
    _aadharCtrl.dispose();  _animCtrl.dispose();
    super.dispose();
  }

  void _register() async {
    if (_companyCtrl.text.trim().isEmpty ||
        _proprietorCtrl.text.trim().isEmpty ||
        _mobileCtrl.text.trim().length != 10) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Fill all required fields correctly'),
        backgroundColor: _C.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _loading = false);
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Row(children: [
        Icon(Icons.check_circle_rounded, color: Colors.white),
        SizedBox(width: 10),
        Text('Registered successfully!'),
      ]),
      backgroundColor: _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.splashBg,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MeshPainter())),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.eco_rounded,
                                color: Color(0xFF4CAF50), size: 16),
                            SizedBox(width: 6),
                            Text('AgroSoft',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _animCtrl,
                    builder: (_, child) => Opacity(
                      opacity: _fadeAnim.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: child,
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2EA84E), Color(0xFF136B2F)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: _C.primary.withOpacity(0.4),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                      Icons.app_registration_rounded,
                                      color: Colors.white, size: 28),
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text('Create Account',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900)),
                                      SizedBox(height: 4),
                                      Text(
                                        'Fill in your business details below',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: _C.surface,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 36,
                                  offset: const Offset(0, 14),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _SectionHeader(
                                    label: 'Business Info',
                                    icon: Icons.business_rounded),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'Company Name *',
                                  hint: 'Enter your company name',
                                  icon: Icons.store_rounded,
                                  controller: _companyCtrl,
                                ),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'Proprietor Name *',
                                  hint: 'Enter proprietor name',
                                  icon: Icons.person_rounded,
                                  controller: _proprietorCtrl,
                                ),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'Mobile Number *',
                                  hint: '10-digit mobile number',
                                  icon: Icons.phone_rounded,
                                  controller: _mobileCtrl,
                                  keyboardType: TextInputType.phone,
                                  maxLength: 10,
                                ),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'Address',
                                  hint: 'Shop / Office address',
                                  icon: Icons.location_on_rounded,
                                  controller: _addressCtrl,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 22),
                                _SectionHeader(
                                    label: 'Legal Documents',
                                    icon: Icons.description_rounded),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'GST Number',
                                  hint: 'e.g. 33AAAAA0000A1Z5',
                                  icon: Icons.receipt_long_rounded,
                                  controller: _gstCtrl,
                                  textCapitalization:
                                  TextCapitalization.characters,
                                ),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'PAN Number',
                                  hint: 'e.g. ABCDE1234F',
                                  icon: Icons.credit_card_rounded,
                                  controller: _panCtrl,
                                  textCapitalization:
                                  TextCapitalization.characters,
                                ),
                                const SizedBox(height: 14),
                                _RegField(
                                  label: 'Aadhar Number',
                                  hint: 'Enter 12-digit Aadhar',
                                  icon: Icons.badge_rounded,
                                  controller: _aadharCtrl,
                                  keyboardType: TextInputType.number,
                                  maxLength: 12,
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _agreed = !_agreed),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                        const Duration(milliseconds: 200),
                                        width: 22, height: 22,
                                        decoration: BoxDecoration(
                                          color: _agreed
                                              ? _C.primary
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                            color: _agreed
                                                ? _C.primary : _C.border,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: _agreed
                                            ? const Icon(Icons.check_rounded,
                                            color: Colors.white, size: 14)
                                            : null,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: RichText(
                                          text: const TextSpan(children: [
                                            TextSpan(
                                              text: 'I agree to the ',
                                              style: TextStyle(
                                                  color: _C.textMid,
                                                  fontSize: 12),
                                            ),
                                            TextSpan(
                                              text: 'Terms & Conditions',
                                              style: TextStyle(
                                                  color: _C.primary,
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w700,
                                                  decoration: TextDecoration
                                                      .underline),
                                            ),
                                            TextSpan(
                                              text:
                                              ' and Privacy Policy of AgroSoft.',
                                              style: TextStyle(
                                                  color: _C.textMid,
                                                  fontSize: 12),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _GreenButton(
                                  label: 'REGISTER',
                                  icon: Icons.how_to_reg_rounded,
                                  loading: _loading,
                                  onTap: _agreed ? _register : null,
                                ),
                                const SizedBox(height: 16),
                                Center(
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: const Text(
                                      'Already have an account? Login',
                                      style: TextStyle(
                                          color: _C.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          decoration:
                                          TextDecoration.underline),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
//  REUSABLE WIDGETS  (unchanged)
// ══════════════════════════════════════════════════════════════════════════════

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  const _OtpBox({required this.controller, required this.focusNode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final filled = controller.text.isNotEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 46, height: 54,
      decoration: BoxDecoration(
        color: filled ? _C.primaryLt : _C.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: filled ? _C.primary : _C.border, width: filled ? 2 : 1),
        boxShadow: filled ? [BoxShadow(color: _C.primary.withOpacity(0.18), blurRadius: 8)] : [],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: const TextStyle(color: _C.primary, fontSize: 20, fontWeight: FontWeight.w900),
        decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
      ),
    );
  }
}

class _RegField extends StatelessWidget {
  final String label, hint;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLength;
  final int maxLines;
  final TextCapitalization textCapitalization;

  const _RegField({
    required this.label, required this.hint, required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLength, this.maxLines = 1,
    this.textCapitalization = TextCapitalization.words,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: _C.textMid, fontSize: 12,
            fontWeight: FontWeight.w700, letterSpacing: 0.3)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          textCapitalization: textCapitalization,
          style: const TextStyle(color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: _C.textLight, fontSize: 13),
            prefixIcon: Icon(icon, color: _C.primary, size: 19),
            counterText: '',
            filled: true,
            fillColor: _C.bg,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.border)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.border)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SectionHeader({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(color: _C.primaryLt, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: _C.primary, size: 16),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: _C.textDark, fontSize: 14, fontWeight: FontWeight.w800)),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: _C.border, thickness: 1)),
      ],
    );
  }
}

class _GreenButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool loading;
  final VoidCallback? onTap;
  const _GreenButton({required this.label, required this.icon, required this.loading, this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null && !loading;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: enabled ? const LinearGradient(
            colors: [Color(0xFF2EA84E), Color(0xFF136B2F)],
            begin: Alignment.centerLeft, end: Alignment.centerRight,
          ) : null,
          color: enabled ? null : _C.textLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          boxShadow: enabled ? [BoxShadow(color: _C.primary.withOpacity(0.38),
              blurRadius: 18, offset: const Offset(0, 7))] : [],
        ),
        child: loading
            ? const Center(child: SizedBox(width: 22, height: 22,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)))
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: Colors.white,
                fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();
  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _ctrl,
    builder: (_, __) => Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        final t = (_ctrl.value - i * 0.15).clamp(0.0, 1.0);
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
  final int index;
  final Animation<double> rot;
  const _FloatingLeaf({required this.index, required this.rot});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final offsets = [
      Offset(size.width * 0.08,  size.height * 0.15),
      Offset(size.width * 0.82,  size.height * 0.10),
      Offset(size.width * 0.05,  size.height * 0.65),
      Offset(size.width * 0.88,  size.height * 0.55),
      Offset(size.width * 0.25,  size.height * 0.85),
      Offset(size.width * 0.72,  size.height * 0.80),
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
              size: sizes[index]),
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
  pageBuilder: (_, a, __) => FadeTransition(opacity: a, child: page),
  transitionDuration: const Duration(milliseconds: 600),
);

PageRoute _slideRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, a, __) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
    child: page,
  ),
  transitionDuration: const Duration(milliseconds: 400),
);