import 'package:flutter/material.dart';
import 'package:frontend/theme/app_color_scheme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _mobileNotification = true;
  bool _smsNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: AppColors.heading)),
        backgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.heading),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // toggle - Mobile App Notifications
              SwitchListTile(
                title: const Text('Mobile App Notifications'),
                value: _mobileNotification,
                onChanged: (value) {
                  setState(() {
                    _mobileNotification = value;
                  });
                },
                activeColor: AppColors.toggleActive,
              ),
              const SizedBox(height: 12),

              // toggle - SMS Notifications
              SwitchListTile(
                title: const Text('SMS Notifications'),
                value: _smsNotification,
                onChanged: (value) {
                  setState(() {
                    _smsNotification = value;
                  });
                },
                activeColor: AppColors.toggleActive,
              ),
              const SizedBox(height: 12),

              // About this app
              ListTile(
                title: const Text(
                  'About this App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(Icons.info_outline),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: AppColors.card,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: Text(
                        'Traffic Notifier',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.heading,
                        ),
                      ),

                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'v1.0.0',
                            style: TextStyle(color: AppColors.heading),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This app checks traffic conditions and notifies you via app and SMS if delays exceed your threshold. Built with Flutter and FastAPI.',
                          ),
                          const SizedBox(height: 12),
                          Text('Created by Alex Antony, 2025'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
