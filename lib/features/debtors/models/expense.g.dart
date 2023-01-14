// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) => Expense(
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
    );

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      'name': instance.name,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
    };
