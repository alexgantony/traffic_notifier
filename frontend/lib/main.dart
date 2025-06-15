import "package:flutter/material.dart";
import "package:frontend/pages/add_route_page.dart";
import "screens/login_page.dart";
import "screens/home_page.dart";
import "app_theme.dart";

void main() {
  runApp(const TrafficNotifierApp());
}

class TrafficNotifierApp extends StatelessWidget {
  const TrafficNotifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Traffic SMS Notifier",
      theme: AppTheme.lightTheme,
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const Home(),
        "/add": (context) => const AddRoutePage(),
      },
    );
  }
}
