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

  Activity copyWith({
    String? sender,
    String? receiver,
    ActivityType? type,
    DateTime? date,
    double? amount,
    String? description,
  }) {
    return Activity(
        id: id,
        type: type ?? this.type,
        date: date ?? this.date,
        amount: amount ?? this.amount,
        description: description ?? this.description,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver);
  }
}

enum ActivityType {
  credit,
  debit,
}
