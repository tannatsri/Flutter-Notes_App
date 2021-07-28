import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  String title = "";
  String desc = "";
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            add();
          },
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: <Widget>[
                Form(
                    child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'title',
                        ),
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'Roboto',
                        ),
                        onChanged: (_val) {
                          title = _val;
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'description',
                      ),
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Roboto',
                      ),
                      onChanged: (_val) {
                        desc = _val;
                      },
                      maxLines: 20,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {
      'title': title,
      'desc': desc,
      'timestamp': DateTime.now(),
    };
    ref.add(data);

    Navigator.pop(context);
  }
}
