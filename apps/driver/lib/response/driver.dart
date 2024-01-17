class Driver {
  final String? id;
  final DriverDetail? details;

  Driver({this.id, this.details});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      details: json['driver_details'] == null
          ? null
          : DriverDetail.fromJson(
              json['driver_details'],
            ),
    );
  }
}

class DriverDetail {
  final String id;

  DriverDetail({required this.id});

  factory DriverDetail.fromJson(Map<String, dynamic> json) {
    return DriverDetail(id: json['id']);
  }
}
