
import 'package:flutter/material.dart';
import 'package:rowdy_hacks/login/client_signup_mail_phone.dart';

class ClientSignup extends StatefulWidget {
  ClientSignup({Key key}) : super(key: key);

  @override
  _ClientSignupState createState() => _ClientSignupState();
}


class _ClientSignupState extends State<ClientSignup> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Column(
              children: <Widget>[
                ClientSignupGmail()
              ],
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}