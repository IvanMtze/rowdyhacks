import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rowdy_hacks/login/AuthService.dart';

class ClientSignupGmail extends StatefulWidget {

  ClientSignupGmail({Key key}) : super(key: key);

  @override
  _ClientSignupGmailState createState() => _ClientSignupGmailState();
}

class _ClientSignupGmailState extends State<ClientSignupGmail> {
  @override
  Widget build(BuildContext context) {
    return EmailAuthWidget();
  }
}



class EmailAuthWidget extends StatefulWidget {

  EmailAuthWidget({Key key}) : super(key: key);

  @override
  _EmailAuthWidgetState createState() => _EmailAuthWidgetState();
}

class _EmailAuthWidgetState extends State<EmailAuthWidget> {
  FocusNode _focusNodePasswdA;
  FocusNode _focusNodePasswdB;
  FocusNode _focusNodeName;
  FocusNode _focusNodeMailPhone;

  final _textEditingControllerPasswdA = TextEditingController();
  final _textEditingControllerPasswdB = TextEditingController();
  final _textEditingControllerName = TextEditingController();
  final _textEditingControllerPasswdmail_phone = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _focusNodePasswdA.dispose();
    _focusNodePasswdB.dispose();
    _focusNodeName.dispose();
    _focusNodeMailPhone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNodePasswdA = FocusNode();
    _focusNodePasswdB = FocusNode();
    _focusNodeName = FocusNode();
    _focusNodeMailPhone = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
            focusNode: _focusNodeMailPhone,
            controller: _textEditingControllerPasswdmail_phone,
            decoration: InputDecoration(
              labelText: "EMAIL",
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            focusNode: _focusNodeName,
            controller: _textEditingControllerName,
            decoration: InputDecoration(
              labelText: "USERNAME",
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            focusNode: _focusNodePasswdA,
            controller: _textEditingControllerPasswdA,
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            focusNode: _focusNodePasswdB,
            controller: _textEditingControllerPasswdB,
            decoration: InputDecoration(
              labelText: 'REPEAT PASSWORD',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: 40,
            child: GestureDetector(
              onTap: () {
                if (_textEditingControllerPasswdmail_phone.text.isEmpty) {
                  _focusNodeMailPhone.requestFocus();
                } else if (_textEditingControllerPasswdA.text.isEmpty) {
                  _focusNodePasswdA.requestFocus();
                } else if (_textEditingControllerPasswdB.text.isEmpty) {
                  _focusNodePasswdB.requestFocus();
                } else if (_textEditingControllerName.text.isEmpty) {
                  _focusNodeName.requestFocus();
                } else if (_textEditingControllerPasswdB.text !=
                    _textEditingControllerPasswdA.text) {
                  _focusNodePasswdB.requestFocus();
                } else {
                  AuthService().signup_with_email(
                      _textEditingControllerPasswdmail_phone.text,
                      _textEditingControllerPasswdA.text,
                    context,
                  );
                }
              },
              child: Material(
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.greenAccent,
                elevation: 7.0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    child: Center(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
