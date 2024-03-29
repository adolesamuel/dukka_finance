import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Income extends Activity {
  Income(
      {required super.id,
      required super.date,
      required super.amount,
      required super.description,
      required super.sender,
      required super.receiver})
      : super(type: ActivityType.credit);

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeToJson(this);
}
