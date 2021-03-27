import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rowdy_hacks/login/AuthService.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final passwdControl = TextEditingController();
  final emailControl = TextEditingController();
  FocusNode passwdFocus;
  FocusNode emailFocus;

  @override
  void initState() {
    super.initState();
    passwdFocus = FocusNode();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    passwdControl.dispose();
    emailControl.dispose();
    passwdFocus.dispose();
    emailFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: ListView(
        children: <Widget>[
          //Title
          Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text(
                      'My',
                      style: TextStyle(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 75, 0, 0),
                    child: Text(
                      'App',
                      style: TextStyle(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(160, 75, 0, 0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
          //End of Title
          Container(
            padding: EdgeInsets.only(top: 0, left: 20, right: 20),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: emailControl,
                  focusNode: emailFocus,
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
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
                  height: 10.0,
                ),
                TextField(
                  controller: passwdControl,
                  focusNode: passwdFocus,
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
                SizedBox(height: 5),
                Container(
                  alignment: Alignment(1, 0),
                  padding: EdgeInsets.only(top: 15.0, left: 20),
                  child: InkWell(
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 80,
                  height: 40,
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    shadowColor: Colors.greenAccent,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {
                        if (emailControl.text.isEmpty) {
                          Scaffold.of(context).showSnackBar(const SnackBar(
                            content: Text('Please write your email'),
                          ));
                          emailFocus.requestFocus();
                        }
                        else {
                          if (passwdControl.text.isEmpty) {
                            Scaffold.of(context).showSnackBar(const SnackBar(
                              content: Text('Please write your password'),
                            ));
                            passwdFocus.requestFocus();
                          }
                          else {
                            AuthService().signin_email(emailControl.text, passwdControl.text,context);
                          }
                        }
                      },
                      child: Center(
                        child: Text(
                          'LOGIN',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  height: 40,
                  child: Material(
                    shadowColor: Colors.greenAccent,
                    elevation: 7.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/btn_google_signin_dark_normal_web.png'),
                            fit: BoxFit.fill,
                        ),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            print("gmail");
                            AuthService().sign_in_with_gmail();
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'New to My App',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 5.0),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/signup");
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

}