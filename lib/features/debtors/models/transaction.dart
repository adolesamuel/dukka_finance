import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Transaction {
  final String id;
  final String name;
  final String sender;
  final String receiver;
  final TransactionType type;
  final DateTime date;
  final double amount;
  final String description;

  Transaction({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
    required this.sender,
    required this.receiver,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

enum TransactionType {
  credit,
  debit,
}
