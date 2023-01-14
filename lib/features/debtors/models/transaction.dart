abstract class Transaction {
  final String name;
  final String sender;
  final String receiver;
  final TransactionType type;
  final DateTime date;
  final double amount;
  final String description;

  Transaction({
    required this.name,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
    required this.sender,
    required this.receiver,
  });
}

enum TransactionType {
  credit,
  debit,
}
