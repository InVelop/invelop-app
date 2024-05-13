import 'package:invelop/models/transaction_model.dart';

class AccountModel {
  final String uid;
  final String accountType;
  final double balance;
  final String name;
  final List<TransactionModel>? transactions;

  AccountModel({
    required this.uid,
    required this.accountType,
    required this.balance,
    required this.name,
    this.transactions,
  });
}
