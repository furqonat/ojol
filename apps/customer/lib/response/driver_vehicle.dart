import 'dart:convert';

DriverVehicle driverVehicleFromJson(String str) => DriverVehicle.fromJson(json.decode(str));

String driverVehicleToJson(DriverVehicle data) => json.encode(data.toJson());

class DriverVehicle {
  String? id;
  String? vehicleType;
  String? driverDetailsId;
  String? vehicleBrand;
  String? vehicleYear;
  String? vehicleImage;
  String? vehicleRegistration;
  String? vehicleRn;

  DriverVehicle({
    this.id,
    this.vehicleType,
    this.driverDetailsId,
    this.vehicleBrand,
    this.vehicleYear,
    this.vehicleImage,
    this.vehicleRegistration,
    this.vehicleRn,
  });

  factory DriverVehicle.fromJson(Map<String, dynamic> json) => DriverVehicle(
    id: json["id"],
    vehicleType: json["vehicle_type"],
    driverDetailsId: json["driver_details_id"],
    vehicleBrand: json["vehicle_brand"],
    vehicleYear: json["vehicle_year"],
    vehicleImage: json["vehicle_image"],
    vehicleRegistration: json["vehicle_registration"],
    vehicleRn: json["vehicle_rn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_type": vehicleType,
    "driver_details_id": driverDetailsId,
    "vehicle_brand": vehicleBrand,
    "vehicle_year": vehicleYear,
    "vehicle_image": vehicleImage,
    "vehicle_registration": vehicleRegistration,
    "vehicle_rn": vehicleRn,
  };
}