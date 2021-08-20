class Transaction {
  final TransactionId id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
    this.id, {
    required this.title,
    required this.amount,
    required this.date,
  });

  Transaction.create({
    required this.title,
    required this.amount,
    required this.date,
  }) : id = TransactionId.next();
}

class TransactionId {
  static var nextId = 0;

  final int value;

  const TransactionId(this.value);

  TransactionId.next() : this(nextId++);
}
