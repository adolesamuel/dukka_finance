// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as String,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.credit: 'credit',
  ActivityType.debit: 'debit',
};
