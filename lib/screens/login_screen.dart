// ─────────────────────────────────────────────────────────────────────────────
//  login_provider.dart  (UI — LoginScreen + OtpScreen + RegisterScreen)
//  Fixed:
//    • OtpScreen._verify() no longer passes latitude/longitude to verifyOtp()
//      (provider reads them from LocationService cache).
//    • Fresh position is fetched and stored into LocationService before the
//      provider call, so the provider always gets up-to-date coords.
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../provider_module/login_provider.dart';
import '../provider_module/otp_verify_provider.dart';
import '../provider_module/location_service.dart';
import '../screens/dashboard_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  COLOUR PALETTE
// ─────────────────────────────────────────────────────────────────────────────
class _C {
  static const bg        = Color(0xFFF2F7F2);
  static const surface   = Colors.white;
  static const primary   = Color(0xFF1B8A3E);
  static const primaryDk = Color(0xFF136B2F);
  static const primaryLt = Color(0xFFE6F4EC);
  static const accent    = Color(0xFF4CAF50);
  static const accentLt  = Color(0xFFA5D6A7);
  static const gold      = Color(0xFFF9A825);
  static const textDark  = Color(0xFF1A2E1A);
  static const textMid   = Color(0xFF5A7260);
  static const textLight = Color(0xFF9DB89E);
  static const border    = Color(0xFFD0E8D4);
  static const red       = Color(0xFFE53935);
  static const splashBg  = Color(0xFF0D4A1F);
}

// ══════════════════════════════════════════════════════════════════════════════
//  LOGIN SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final _phoneCtrl = TextEditingController();
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
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  // ── Calls OtpVerifyProvider.login() → on success navigates to OTP screen ──
  Future<void> _proceed() async {
    final mobile = _phoneCtrl.text.trim();
    if (mobile.length != 10) {
      _snack('Enter a valid 10-digit mobile number', error: true);
      HapticFeedback.mediumImpact();
      return;
    }

    final auth = context.read<OtpVerifyProvider>();
    final ok   = await auth.login(mobile: mobile);

    if (!mounted) return;

    if (ok) {
      Navigator.push(context, _slideRoute(OtpScreen(phone: mobile)));
    } else {
      HapticFeedback.mediumImpact();
      _snack(
        auth.message.isNotEmpty ? auth.message : 'Login failed. Try again.',
        error: true,
      );
    }
  }

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: error ? _C.red : _C.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  void _goToRegister() {
    Navigator.push(context, _slideRoute(const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<OtpVerifyProvider>().isLoading;
    final size      = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _C.splashBg,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _MeshPainter())),
          Positioned(
            top: -60,
            left: size.width * 0.5 - 160,
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
                        TextSpan(
                          text: 'Agro',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5),
                        ),
                        TextSpan(
                          text: 'Soft',
                          style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5),
                        ),
                      ]),
                    ),
                    const Spacer(),
                    AnimatedBuilder(
                      animation: _animCtrl,
                      builder: (_, child) => Opacity(
                        opacity: _fadeAnim.value,
                        child: Transform.translate(
                            offset: Offset(0, _slideAnim.value),
                            child: child),
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
                            Row(children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: _C.primaryLt,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                    Icons.waving_hand_rounded,
                                    color: _C.primary,
                                    size: 22),
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
                            ]),
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
                              child: Row(children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 16),
                                  decoration: const BoxDecoration(
                                    color: _C.primaryLt,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    ),
                                  ),
                                  child: const Row(children: [
                                    Text('🇮🇳',
                                        style: TextStyle(fontSize: 18)),
                                    SizedBox(width: 6),
                                    Text('+91',
                                        style: TextStyle(
                                            color: _C.primary,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14)),
                                  ]),
                                ),
                                Container(
                                    width: 1, height: 28, color: _C.border),
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
                              ]),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "  We'll send a 6-digit OTP to verify",
                              style: TextStyle(
                                  color: _C.textLight,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 28),
                            _GreenButton(
                              label: 'GET OTP',
                              icon: Icons.arrow_forward_rounded,
                              loading: isLoading,
                              onTap: isLoading ? null : _proceed,
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: _goToRegister,
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
                                          decoration:
                                          TextDecoration.underline),
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
//  OTP SCREEN
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
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

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
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
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

  Future<void> _verify() async {
    if (_otp.length < 6) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Enter the 6-digit OTP'),
        backgroundColor: _C.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ));
      return;
    }

    setState(() => _loading = true);

    // ── Refresh location cache so the provider gets current coords ──────────
    // We attempt a fresh position and update the static LocationService cache.
    // If it fails, the splash-time cache (or zeros) are used instead.
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 8));
      LocationService.lt      = pos.latitude;
      LocationService.ln      = pos.longitude;
      LocationService.fetched = true;
    } catch (_) {
      // Keep whatever value was set at splash, or 0.0 if never fetched.
    }

    // ── Real device/FCM values should come from DeviceInfoPlugin / Firebase ─
    // Replace these placeholder strings before shipping.
    const deviceId = 'DEVICE_ID_HERE';
    const fcmToken = 'FCM_TOKEN_HERE';

    final auth = context.read<OtpVerifyProvider>();

    // ✅ No latitude/longitude params — provider reads LocationService cache.
    final ok = await auth.verifyOtp(
      otp:      _otp,
      deviceId: deviceId,
      fcmToken: fcmToken,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (ok) {
      Navigator.pushAndRemoveUntil(
        context,
        _fadeRoute(const DashboardScreen()),
            (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Row(children: [
          Icon(Icons.check_circle_rounded, color: Colors.white),
          SizedBox(width: 10),
          Text('Login Successful!'),
        ]),
        backgroundColor: _C.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ));
    } else {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(auth.message.isNotEmpty
            ? auth.message
            : 'Invalid OTP. Please try again.'),
        backgroundColor: _C.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ));
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _canResend  = false;
      _resendSecs = 30;
      for (final c in _ctls) c.clear();
    });

    final auth = context.read<OtpVerifyProvider>();
    final ok   = await auth.login(mobile: widget.phone);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? 'OTP resent successfully'
          : auth.message.isNotEmpty
          ? auth.message
          : 'Failed to resend OTP'),
      backgroundColor: ok ? _C.primary : _C.red,
      behavior: SnackBarBehavior.floating,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));

    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    final masked = '+91 ${widget.phone.substring(0, 4)}******';

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
                      child: Row(children: [
                        IconButton(
                          icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Spacer(),
                        const Text('AgroSoft',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700)),
                      ]),
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
                            child: child),
                      ),
                      child: Container(
                        margin:
                        const EdgeInsets.symmetric(horizontal: 20),
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
                            const Text('Enter 6-Digit OTP',
                                style: TextStyle(
                                    color: _C.textDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 24),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                const gapTotal = 5 * 8.0;
                                final boxSize =
                                    (constraints.maxWidth - gapTotal) /
                                        6;
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    6,
                                        (i) => _OtpBox(
                                      boxSize: boxSize,
                                      controller: _ctls[i],
                                      focusNode: _focusNodes[i],
                                      onChanged: (val) {
                                        if (val.isNotEmpty && i < 5) {
                                          _focusNodes[i + 1]
                                              .requestFocus();
                                        }
                                        if (val.isEmpty && i > 0) {
                                          _focusNodes[i - 1]
                                              .requestFocus();
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 28),
                            _GreenButton(
                              label: 'VERIFY OTP',
                              icon: Icons.shield_rounded,
                              loading: _loading,
                              onTap: _loading ? null : _verify,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Didn't receive? ",
                                    style: TextStyle(
                                        color: _C.textMid,
                                        fontSize: 13)),
                                GestureDetector(
                                  onTap: _canResend ? _resendOtp : null,
                                  child: Text(
                                    _canResend
                                        ? 'Resend OTP'
                                        : 'Resend in ${_resendSecs}s',
                                    style: TextStyle(
                                      color: _canResend
                                          ? _C.primary
                                          : _C.textLight,
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
//  REGISTER SCREEN
// ══════════════════════════════════════════════════════════════════════════════
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {

  final _companyCtrl    = TextEditingController();
  final _proprietorCtrl = TextEditingController();
  final _mobileCtrl     = TextEditingController();
  final _addressCtrl    = TextEditingController();
  final _gstCtrl        = TextEditingController();
  final _panCtrl        = TextEditingController();
  final _aadharCtrl     = TextEditingController();
  bool _loading = false;
  bool _agreed  = false;

  late AnimationController _animCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<double>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn));
    _slideAnim = Tween<double>(begin: 60, end: 0).animate(
        CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _proprietorCtrl.dispose();
    _mobileCtrl.dispose();
    _addressCtrl.dispose();
    _gstCtrl.dispose();
    _panCtrl.dispose();
    _aadharCtrl.dispose();
    _animCtrl.dispose();
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
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
                  child: Row(children: [
                    IconButton(
                      icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20),
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
                  ]),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _animCtrl,
                    builder: (_, child) => Opacity(
                      opacity: _fadeAnim.value,
                      child: Transform.translate(
                          offset: Offset(0, _slideAnim.value),
                          child: child),
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
                                colors: [
                                  Color(0xFF2EA84E),
                                  Color(0xFF136B2F)
                                ],
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
                            child: Row(children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                  Colors.white.withOpacity(0.18),
                                  borderRadius:
                                  BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                    Icons.app_registration_rounded,
                                    color: Colors.white,
                                    size: 28),
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
                                            fontWeight:
                                            FontWeight.w900)),
                                    SizedBox(height: 4),
                                    Text(
                                        'Fill in your business details below',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: _C.surface,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  Colors.black.withOpacity(0.12),
                                  blurRadius: 36,
                                  offset: const Offset(0, 14),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                  onTap: () => setState(
                                          () => _agreed = !_agreed),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                            milliseconds: 200),
                                        width: 22, height: 22,
                                        decoration: BoxDecoration(
                                          color: _agreed
                                              ? _C.primary
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(
                                              6),
                                          border: Border.all(
                                            color: _agreed
                                                ? _C.primary
                                                : _C.border,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: _agreed
                                            ? const Icon(
                                            Icons.check_rounded,
                                            color: Colors.white,
                                            size: 14)
                                            : null,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: RichText(
                                          text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'I agree to the ',
                                                  style: TextStyle(
                                                      color: _C.textMid,
                                                      fontSize: 12),
                                                ),
                                                TextSpan(
                                                  text:
                                                  'Terms & Conditions',
                                                  style: TextStyle(
                                                      color: _C.primary,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      decoration:
                                                      TextDecoration
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
                                    onTap: () =>
                                        Navigator.pop(context),
                                    child: const Text(
                                      'Already have an account? Login',
                                      style: TextStyle(
                                          color: _C.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration
                                              .underline),
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
//  REUSABLE WIDGETS
// ══════════════════════════════════════════════════════════════════════════════
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode             focusNode;
  final ValueChanged<String>  onChanged;
  final double                boxSize;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.boxSize,
  });

  @override
  Widget build(BuildContext context) {
    final filled = controller.text.isNotEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width:  boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: filled ? _C.primaryLt : _C.bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: filled ? _C.primary : _C.border,
          width: filled ? 2 : 1,
        ),
        boxShadow: filled
            ? [
          BoxShadow(
              color: _C.primary.withOpacity(0.18),
              blurRadius: 8)
        ]
            : [],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 1,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: onChanged,
          style: TextStyle(
            color: _C.primary,
            fontSize: boxSize * 0.40,
            fontWeight: FontWeight.w900,
            height: 1.0,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            isCollapsed: true,
          ),
        ),
      ),
    );
  }
}

class _RegField extends StatelessWidget {
  final String                label, hint;
  final IconData              icon;
  final TextEditingController controller;
  final TextInputType         keyboardType;
  final int?                  maxLength;
  final int                   maxLines;
  final TextCapitalization    textCapitalization;

  const _RegField({
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyboardType       = TextInputType.text,
    this.maxLength,
    this.maxLines           = 1,
    this.textCapitalization = TextCapitalization.words,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: _C.textMid,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          textCapitalization: textCapitalization,
          style: const TextStyle(
              color: _C.textDark,
              fontSize: 14,
              fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
            const TextStyle(color: _C.textLight, fontSize: 13),
            prefixIcon: Icon(icon, color: _C.primary, size: 19),
            counterText: '',
            filled: true,
            fillColor: _C.bg,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.border)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _C.border)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                const BorderSide(color: _C.primary, width: 1.5)),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String   label;
  final IconData icon;
  const _SectionHeader({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: _C.primaryLt,
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: _C.primary, size: 16),
        ),
        const SizedBox(width: 10),
        Text(label,
            style: const TextStyle(
                color: _C.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w800)),
        const SizedBox(width: 8),
        Expanded(child: Divider(color: _C.border, thickness: 1)),
      ],
    );
  }
}

class _GreenButton extends StatelessWidget {
  final String        label;
  final IconData      icon;
  final bool          loading;
  final VoidCallback? onTap;

  const _GreenButton({
    required this.label,
    required this.icon,
    required this.loading,
    this.onTap,
  });

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
          gradient: enabled
              ? const LinearGradient(
            colors: [Color(0xFF2EA84E), Color(0xFF136B2F)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
              : null,
          color: enabled ? null : _C.textLight.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          boxShadow: enabled
              ? [
            BoxShadow(
                color: _C.primary.withOpacity(0.38),
                blurRadius: 18,
                offset: const Offset(0, 7))
          ]
              : [],
        ),
        child: loading
            ? const Center(
          child: SizedBox(
            width: 22, height: 22,
            child: CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2.5),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }
}

// ── Painters & route helpers ──────────────────────────────────────────────────
class _MeshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = const Color(0xFF0A3D18);
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), paint);
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

PageRoute _fadeRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, a, __) =>
      FadeTransition(opacity: a, child: page),
  transitionDuration: const Duration(milliseconds: 600),
);

PageRoute _slideRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, a, __) => SlideTransition(
    position: Tween<Offset>(
        begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(
        parent: a, curve: Curves.easeOutCubic)),
    child: page,
  ),
  transitionDuration: const Duration(milliseconds: 400),
);