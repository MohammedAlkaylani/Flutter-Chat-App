import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends ChangeNotifier {
  // Firebase Auth instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _fireStore.collection("users").doc(userCredential.user?.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      }, SetOptions(merge: true));
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // // Register with email and password
  Future<UserCredential> signUpWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _fireStore.collection("users").doc(userCredential.user?.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // Check if user exists

  Future<bool> checkUserExists(String email) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: "dummyPassword",
      );
      // If we succeed, immediately delete that user (if you don't want this persisting) and return false
      await _firebaseAuth.currentUser?.delete();
      return false; // user did *not* exist before
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return true;
      } else {
        rethrow;
      }
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  // // Get current user
  // User? getCurrentUser() {
  //   return _auth.currentUser;
  // }
}
