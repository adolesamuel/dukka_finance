import 'package:json_annotation/json_annotation.dart';

part 'debtor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Debtor {
  final String id;
  final String name;
  final String date;
  final String paymentDueDate;
  final String email;
  final String phoneNumber;
  final double debtAmount;
  final double amountPaid;
  final String lastContactDate;
  final double isPaymentComplete;

  Debtor({
    required this.id,
    required this.name,
    required this.date,
    required this.paymentDueDate,
    required this.email,
    required this.phoneNumber,
    required this.debtAmount,
    required this.amountPaid,
    required this.lastContactDate,
    required this.isPaymentComplete,
  });
  factory Debtor.fromJson(Map<String, dynamic> json) => _$DebtorFromJson(json);

  Map<String, dynamic> toJson() => _$DebtorToJson(this);
}
