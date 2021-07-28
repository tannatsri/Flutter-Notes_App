import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/pages/home.dart';

GoogleSignIn google_sign_in = GoogleSignIn();
final FirebaseAuth firebase_auth = FirebaseAuth.instance;

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<bool> signIn(BuildContext context) async {
  try {
    final GoogleSignInAccount? account = await google_sign_in.signIn();

    if (account != null) {
      final GoogleSignInAuthentication gauthentication =
          await account.authentication;

      print(gauthentication);
      final AuthCredential authentication = GoogleAuthProvider.credential(
          accessToken: gauthentication.accessToken,
          idToken: gauthentication.idToken);

      final UserCredential authResult =
          await firebase_auth.signInWithCredential(authentication);

      final User? user = authResult.user;
      var userData = {
        'name': account.displayName,
        'email': account.email,
        'photoUrl': account.photoUrl,
        'provider': 'google',
      };
      users.doc(user?.uid).get().then((doc) {
        if (doc.exists) {
          doc.reference.update(userData);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          users.doc(user?.uid).set(userData);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      });
    }
  } catch (e) {
    print(e);
    print("Sign in failed");
  }

  return true;
}
