import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DashboardData {
  final String id;
  final String email;
  final String fullName;
  final double balance;
  final List<Transaction> transactions;
  final List<Debt> debts;

  DashboardData({
    required this.id,
    required this.balance,
    required this.transactions,
    required this.email,
    required this.fullName,
    required this.debts,
  });
  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}
