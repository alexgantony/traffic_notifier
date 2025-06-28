import 'package:flutter/material.dart';
import 'package:frontend/models/route_info.dart';
import 'package:frontend/theme/app_color_scheme.dart';
import 'package:frontend/screens/route_detail_screen.dart';
import 'package:frontend/screens/add_route_screen.dart';

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
                route.routeLabel,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
              subtitle: Text(
                '${route.sourceAddress} → ${route.destinationAddress}',
              ),
              leading: const Icon(Icons.route),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RouteDetailScreen(route: route),
                  ),
                );
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
        onPressed: () async {
          final newRoute = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRouteScreen()),
          );

          if (newRoute != null) {
            // TODO: Backend - Append to route list
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('New route \'${newRoute.routeLabel}\' added!'),
              ),
            );
          }
        },
      ),
    );
  }
}

final List<RouteDetailInfo> routes = [
  RouteDetailInfo(
    id: 1,
    routeLabel: 'Work Commute',
    sourceAddress: 'Home',
    destinationAddress: 'Office',
    delayThreshold: 10,
    trafficCheckTime: DateTime.now(),
    alertTime: const TimeOfDay(hour: 8, minute: 0),
  ),
  RouteDetailInfo(
    id: 2,
    routeLabel: 'Gym Route',
    sourceAddress: 'Office',
    destinationAddress: 'Gym',
    delayThreshold: 5,
    trafficCheckTime: DateTime.now(),
    alertTime: const TimeOfDay(hour: 18, minute: 30),
  ),
  RouteDetailInfo(
    id: 3,
    routeLabel: 'Week Drive',
    sourceAddress: 'Home',
    destinationAddress: 'Beach',
    delayThreshold: 20,
    trafficCheckTime: DateTime.now(),
    alertTime: const TimeOfDay(hour: 9, minute: 0),
  ),
];
