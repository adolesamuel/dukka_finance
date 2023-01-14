// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      id: json['id'] as String,
      balance: (json['balance'] as num).toDouble(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      debts: (json['debts'] as List<dynamic>)
          .map((e) => Debt.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'balance': instance.balance,
      'transactions': instance.transactions,
      'debts': instance.debts,
    };
