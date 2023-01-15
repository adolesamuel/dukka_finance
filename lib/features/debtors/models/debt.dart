import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'debt.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Debt extends Transaction {
  final DateTime dueDate;
  final bool isPaid;

  Debt({
    required super.id,
    required super.type,
    required super.date,
    required super.amount,
    required super.description,
    required super.sender,
    required super.receiver,
    required this.dueDate,
    required this.isPaid,
  });

  factory Debt.fromJson(Map<String, dynamic> json) => _$DebtFromJson(json);

  Map<String, dynamic> toJson() => _$DebtToJson(this);
}
