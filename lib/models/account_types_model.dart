// Define a model class to hold account types data
import 'package:flutter/material.dart';

class AccountTypesModel {
  final String uid;
  final String name;
  final String slug;

  AccountTypesModel(
      {required this.uid, required this.name, required this.slug});
}

// Define a provider class to manage the AccountTypesModel data
class AccountTypesProvider with ChangeNotifier {
  AccountTypesModel? _accountTypesModel;

  AccountTypesModel? get accountTypes => _accountTypesModel;

  void setAccountTypes(AccountTypesModel accountTypes) {
    _accountTypesModel = accountTypes;
    notifyListeners();
  }
}
