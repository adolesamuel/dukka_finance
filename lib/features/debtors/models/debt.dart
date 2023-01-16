import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'debt.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Debt extends Activity {
  final DateTime dueDate;
  final bool isPaid;
  final String? receiverPhoneNumber;
  final String? receiverEmail;
  final DateTime? lastContactDate;

  Debt({
    required super.id,
    required super.amount,
    required super.description,
    required super.receiver,
    required super.sender,
    required super.date,
    required this.dueDate,
    required this.isPaid,
    this.receiverPhoneNumber,
    this.receiverEmail,
    this.lastContactDate,
  }) : super(type: ActivityType.debit);

  factory Debt.fromJson(Map<String, dynamic> json) => _$DebtFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DebtToJson(this);
}
