// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Debt _$DebtFromJson(Map<String, dynamic> json) => Debt(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      date: DateTime.parse(json['date'] as String),
      dueDate: DateTime.parse(json['due_date'] as String),
      isPaid: json['is_paid'] as bool,
      receiverPhoneNumber: json['receiver_phone_number'] as String?,
      receiverEmail: json['receiver_email'] as String?,
      lastContactDate: json['last_contact_date'] == null
          ? null
          : DateTime.parse(json['last_contact_date'] as String),
    );

Map<String, dynamic> _$DebtToJson(Debt instance) => <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'description': instance.description,
      'due_date': instance.dueDate.toIso8601String(),
      'is_paid': instance.isPaid,
      'receiver_phone_number': instance.receiverPhoneNumber,
      'receiver_email': instance.receiverEmail,
      'last_contact_date': instance.lastContactDate?.toIso8601String(),
    };
