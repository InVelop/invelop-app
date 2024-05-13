import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:invelop/models/account_model.dart';
import 'package:invelop/models/transaction_model.dart';
import 'package:invelop/models/user_model.dart';
import 'package:provider/provider.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> fetchUserAccountsAndTransactions(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.uid;

    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      final accountsSnapshot =
          await userDoc.reference.collection('accounts').get();

      final accounts = await Future.wait(accountsSnapshot.docs.map((doc) async {
        final data = doc.data();

        final transactionsSnapshot =
            await doc.reference.collection('transactions').get();
        final transactions = transactionsSnapshot.docs.map((transactionDoc) {
          final transactionData = transactionDoc.data();
          return TransactionModel(
              uid: transactionDoc.id,
              amount: transactionData['amount'].toDouble(),
              category: transactionData['category'],
              date: transactionData['date'].toDate(),
              name: transactionData['name'],
              type: transactionData['type'],
              accountName: transactionData['account_name']);
        }).toList();

        return AccountModel(
          uid: doc.id,
          accountType: data['account_type'],
          balance: data['balance'].toDouble(),
          name: data['name'],
          transactions: transactions,
        );
      }).toList());

      // Update the user in the provider with the fetched accounts
      final user = UserModel(
        uid: userProvider.user?.uid,
        email: userProvider.user?.email,
        accounts: accounts,
      );

      userProvider.setUser(user);
    }
  }
}
