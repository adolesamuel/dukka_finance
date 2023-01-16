import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Activity {
  final String id;
  final String sender;
  final String receiver;
  final ActivityType type;
  final DateTime date;
  final double amount;
  final String description;

  Activity({
    required this.id,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
    required this.sender,
    required this.receiver,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

enum ActivityType {
  credit,
  debit,
}
