import 'package:json_annotation/json_annotation.dart';

part 'dashboard_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardData {
  final String id;
  final String email;
  final String fullName;
  final double balance;

  DashboardData({
    required this.id,
    required this.balance,
    required this.email,
    required this.fullName,
  });
  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
