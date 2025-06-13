import 'package:flutter/material.dart';
import '../app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
Widget build(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  return Scaffold(
    backgroundColor: AppColors.primaryTeal,
    body: Stack(
      alignment: Alignment.topCenter,
      children: [
        // Car Icon with visible white border
        Positioned(
          top: 200,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryTeal,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: const Icon(Icons.traffic_outlined, size: 50, color: Colors.white),
          ),
        ),

        // Login Card - now stretched to bottom with rounded top corners
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 675,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Traffic SMS Notifier",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('LOG IN'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}