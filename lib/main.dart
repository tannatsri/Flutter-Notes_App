import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/home.dart';
import 'package:notes_app/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {   
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY Notes',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      home: LoginPage(),
    );
  }
}
