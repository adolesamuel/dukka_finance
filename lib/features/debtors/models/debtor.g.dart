// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debtor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Debtor _$DebtorFromJson(Map<String, dynamic> json) => Debtor(
      id: json['id'] as String,
      name: json['name'] as String,
      date: json['date'] as String,
      paymentDueDate: json['payment_due_date'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      debts: (json['debts'] as List<dynamic>)
          .map((e) => Debt.fromJson(e as Map<String, dynamic>))
          .toList(),
      amountPaid: (json['amount_paid'] as num).toDouble(),
      lastContactDate: json['last_contact_date'] as String,
      isPaymentComplete: (json['is_payment_complete'] as num).toDouble(),
    );

Map<String, dynamic> _$DebtorToJson(Debtor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'payment_due_date': instance.paymentDueDate,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'debts': instance.debts,
      'amount_paid': instance.amountPaid,
      'last_contact_date': instance.lastContactDate,
      'is_payment_complete': instance.isPaymentComplete,
    };
