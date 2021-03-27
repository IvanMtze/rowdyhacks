
import 'package:flutter/material.dart';
import 'package:rowdy_hacks/login/client_signup.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign up.',
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
            ),
          ]
        ),
        body: ListView(
          children: <Widget>[
            Container(
              child:ClientSignup()
            ), //I have no idea if this works
            //Already register?
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already register?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login", (route) => false);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40)
          ],
        ));
  }
}