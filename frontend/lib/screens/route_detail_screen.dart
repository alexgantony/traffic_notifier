import 'package:flutter/material.dart';
import 'package:frontend/theme/app_color_scheme.dart';
import 'package:frontend/models/route_info.dart';
import 'package:intl/intl.dart';

class RouteDetailScreen extends StatelessWidget {
  final RouteDetailInfo route;

  const RouteDetailScreen({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  route.routeLabel,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.heading,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: AppColors.heading,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Source: ${route.sourceAddress}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.heading,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            size: 20,
                            color: AppColors.heading,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Destination: ${route.destinationAddress}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.heading,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 20,
                            color: AppColors.heading,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Notify if delay exceeds (mins): ${route.delayThreshold}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.heading,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),

                      // Alert Time
                      if (route.alertTime != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 20,
                              color: AppColors.heading,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Check at: ${route.alertTime!.format(context)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.heading,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    // edit button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to edit screen
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.heading,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // delete button
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Route?'),
                              content: Text(
                                'Are you sure you want to delete the \'${route.routeLabel}\' route?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '"${route.routeLabel}" deleted!',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
