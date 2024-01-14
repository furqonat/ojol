class DanaProfile {
  final String resourceType;
  final dynamic value;

  DanaProfile({required this.resourceType, required this.value});

  factory DanaProfile.fromJson(Map<String, dynamic> json) {
    return DanaProfile(
      resourceType: json['resourceType'],
      value: json['value'],
    );
  }
}
