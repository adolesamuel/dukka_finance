import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Expense extends Activity {
  Expense(
      {required super.id,
      required super.date,
      required super.amount,
      required super.description,
      required super.sender,
      required super.receiver})
      : super(type: ActivityType.debit);

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
