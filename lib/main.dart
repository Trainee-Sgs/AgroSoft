import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'provider_module/login_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'provider_module/otp_verify_provider.dart';
import 'provider_module/ledger_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const AgrosoftApp());
}

class AgrosoftApp extends StatelessWidget {
  const AgrosoftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<OtpVerifyProvider>(
          create: (_) => OtpVerifyProvider(),
        ),
        ChangeNotifierProvider(create: (_) => LedgerProvider()),
      ],
      child: MaterialApp(
        title: 'AgroSoft',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}