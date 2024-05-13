class TransactionModel {
  final String uid;
  final DateTime date;
  final String name;
  final String category;
  final String type;
  final double amount;
  final String? accountName;

  TransactionModel(
      {required this.uid,
      required this.date,
      required this.name,
      required this.category,
      required this.type,
      required this.amount,
      required this.accountName});
}
