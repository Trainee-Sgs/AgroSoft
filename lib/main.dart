import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
// import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF6A5ACD), // pastel purple
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AgrosoftApp());
}

class AgrosoftApp extends StatelessWidget {
  const AgrosoftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AGROSOFT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}