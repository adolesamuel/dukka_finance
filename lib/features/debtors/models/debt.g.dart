// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Debt _$DebtFromJson(Map<String, dynamic> json) => Debt(
      name: json['name'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      isPaid: json['is_paid'] as bool,
    );

Map<String, dynamic> _$DebtToJson(Debt instance) => <String, dynamic>{
      'name': instance.name,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
      'due_date': instance.dueDate.toIso8601String(),
      'is_paid': instance.isPaid,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.credit: 'credit',
  TransactionType.debit: 'debit',
};
