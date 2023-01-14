// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'name': instance.name,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
    };
