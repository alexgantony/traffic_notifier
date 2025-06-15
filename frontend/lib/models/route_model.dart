class RouteModel {
  final int id;
  final String sourceAddress;
  final String destinationAddress;
  final String routeLabel;
  final int delayThreshold;
  final String alertTime;

  RouteModel({
    required this.id,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.routeLabel,
    required this.delayThreshold,
    required this.alertTime,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      id: json['id'],
      sourceAddress: json["source_address"],
      destinationAddress: json["destination_address"],
      routeLabel: json["route_label"] ?? '',
      delayThreshold: json["delay_threshold"],
      alertTime: json['alert_time'],
    );
  }
}
