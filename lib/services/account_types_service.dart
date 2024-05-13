import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:invelop/models/account_types_model.dart';
import 'package:provider/provider.dart';

class AccountTypesService {
  final FirebaseFirestore _firestore;

  AccountTypesService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> fetchAccountTypes(BuildContext context) async {
    final accountTypesProvider =
        Provider.of<AccountTypesProvider>(context, listen: false);

    final snapshot = await _firestore.collection('account_type').get();

    snapshot.docs.forEach((doc) {
      final data = doc.data();
      final id = doc.id;
      final accountTypes = AccountTypesModel(
        uid: id,
        name: data['name'],
        slug: data['slug'],
      );

      accountTypesProvider.setAccountTypes(accountTypes);
    });
  }
}
