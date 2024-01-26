class OperationTime {
  final String? id;
  final String? day;
  final String? startTime;
  final String? endTime;
  final bool? status;

  OperationTime({
    this.id,
    this.day,
    this.startTime,
    this.endTime,
    this.status,
  });

  factory OperationTime.fromJson(Map<String, dynamic> json) {
    return OperationTime(
      id: json['id'],
      day: json['day'],
      startTime: json['open_time'],
      endTime: json['close_time'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'day': day,
        'start_time': startTime,
        'end_time': endTime,
      };
}
