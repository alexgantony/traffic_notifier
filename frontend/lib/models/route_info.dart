import 'package:flutter/material.dart';

class RouteDetailInfo {
  final int id;
  final String routeLabel;
  final String sourceAddress;
  final String destinationAddress;
  final int delayThreshold;
  final DateTime? trafficCheckTime;
  final TimeOfDay? alertTime;

  RouteDetailInfo({
    required this.id,
    required this.routeLabel,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.delayThreshold,
    this.trafficCheckTime,
    this.alertTime,
  });
}
