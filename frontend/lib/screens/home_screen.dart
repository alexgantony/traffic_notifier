import 'package:flutter/material.dart';
import 'package:frontend/models/route_info.dart';
import 'package:frontend/theme/app_color_scheme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Routes',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.heading,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: AppColors.card,
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                route.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
              subtitle: Text('${route.from} → ${route.to}'),
              leading: const Icon(Icons.route),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigation
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.card,
        child: Icon(
          Icons.add,
          color: AppColors.heading,
          semanticLabel: 'Add a new route',
        ),
        onPressed: () {
          // Navigate to Add Route Screen
        },
      ),
    );
  }
}

final List<RouteInfo> routes = [
  RouteInfo(name: 'Work Commute', from: 'Home', to: 'Office'),
  RouteInfo(name: 'Gym Route', from: 'Office', to: 'Gym'),
  RouteInfo(name: 'Week Drive', from: 'Home', to: 'Beach'),
];
