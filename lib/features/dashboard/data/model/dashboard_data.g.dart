// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      id: json['id'] as String,
      balance: (json['balance'] as num).toDouble(),
      email: json['email'] as String,
      fullName: json['full_name'] as String,
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.fullName,
      'balance': instance.balance,
    };
