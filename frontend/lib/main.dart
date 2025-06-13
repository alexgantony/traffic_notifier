import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'app_theme.dart';

void main() {
  runApp(const TrafficNotifierApp());
}

class TrafficNotifierApp extends StatelessWidget {
  const TrafficNotifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traffic SMS Notifier',
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
