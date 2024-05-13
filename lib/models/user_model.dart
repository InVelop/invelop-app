// Define a model class to hold user data
import 'package:flutter/material.dart';
import 'package:invelop/models/account_model.dart';

class UserModel {
  final String? uid;
  final String? email;
  final List<AccountModel>? accounts;

  UserModel({required this.uid, required this.email, this.accounts});
}

// Define a provider class to manage user data
class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void cleanUser() {
    _user = null;
    notifyListeners();
  }
}
