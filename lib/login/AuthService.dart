import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rowdy_hacks/login/login.dart';
import 'package:rowdy_hacks/landing/home.dart';

class AuthService {
  //Handles Auth
  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // Navigator.of(context).pop();
            return Home();
          } else {
            return Login();
          }
        });
  }

  Future<UserCredential> sign_in_with_gmail() async {
    _signin_with_gmail();
  }
  Future<UserCredential> _signin_with_gmail() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signin_email(email, password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text('User not found with that email.'),
        ));
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text('Wrong password, please try again'),
        ));
      }
    }
  }

  Future<bool> signup_with_email(
      _email, _passwd, BuildContext _context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _passwd);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Scaffold.of(_context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
        ));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Scaffold.of(_context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
        ));
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}