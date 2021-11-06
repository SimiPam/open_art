import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'package:open_art/core/model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User _user(auth.User user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map(_user);
  }

  Future register(String email, String password) async {
    setLoading(true);
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      setLoading(false);
      return _user(authResult.user);
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to internet");
    } catch (e) {
      setLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  Future<User> login(String email, String password) async {
    setLoading(true);
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // User user = authResult.user;

      setLoading(false);
      return _user(authResult.user);
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to internet");
    } catch (e) {
      setLoading(false);
      setMessage(e.message);
    }
    notifyListeners();
  }

  Future logout() async {
    await _firebaseAuth.signOut();
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Stream<User> get user =>
  //     firebaseAuth.authStateChanges().map((event) => event);
}
