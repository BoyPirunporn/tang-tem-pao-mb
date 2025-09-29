class NetWorthSnapshotModel {
  final DateTime snapshotDate;
  final double netWorth;

  NetWorthSnapshotModel({
    required this.snapshotDate,
    required this.netWorth,
  });

  factory NetWorthSnapshotModel.fromJson(Map<String, dynamic> json) {
    return NetWorthSnapshotModel(
      snapshotDate: DateTime.parse(json['snapshotDate']),
      netWorth: (json['netWorth'] as num).toDouble(),
    );
  }
}
