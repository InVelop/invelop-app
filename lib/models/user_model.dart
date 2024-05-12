// Define a model class to hold user data
import 'package:flutter/material.dart';

class UserModel {
  final String? uid;
  final String? email;

  UserModel({required this.uid, required this.email});
}

// Define a provider class to manage user data
class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
