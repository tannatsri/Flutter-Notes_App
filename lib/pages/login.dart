// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:notes_app/controller/google_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 400.0),
          Text('The all in one notes feature'),
          SizedBox(height: 40.0),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.orange.shade600)),
            onPressed: () {
              signIn(context);
            },
            child: Text('Login with Google',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                )),
          )
        ],
      ),
    ));
  }
}
