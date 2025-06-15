import "package:flutter/material.dart";
import "../app_colors.dart";
import "package:frontend/models/route_model.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
                title: const Text("My Routes"),
                backgroundColor: AppColors.primaryTeal,
                centerTitle: true,
            ),
           body: ListView.builder(
              itemCount: dummyRoutes.length,
              itemBuilder: (context, index) {
                final route = dummyRoutes[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(route.routeLabel),
                    subtitle: Text("${route.sourceAddress} ➜ ${route.destinationAddress}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(route.alertTime),
                        Text("${route.delayThreshold} min"),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              Navigator.pushNamed(context, "/add");
            },
            shape: const CircleBorder(),
            elevation: 10,
            backgroundColor: AppColors.primaryTeal,
            child: const Icon(Icons.add),
            ),
        );
  }
}

final List<RouteModel> dummyRoutes = [
  RouteModel(
    id: 1,
    sourceAddress: "Home",
    destinationAddress: "Office",
    routeLabel: "Daily Commute",
    delayThreshold: 20,
    alertTime: "08:00", // must match format you plan to use from API
  ),
  RouteModel(
    id: 2,
    sourceAddress: "Office",
    destinationAddress: "Home",
    routeLabel: "Evening Return",
    delayThreshold: 25,
    alertTime: "18:30",
  ),
];