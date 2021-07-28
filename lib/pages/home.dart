import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/pages/addNote.dart';
import 'package:notes_app/pages/viewNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');
  List<Color> color = [
    Colors.cyan[200]!,
    Colors.red[300]!,
    Colors.blue[300]!,
    Colors.green[300]!
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddNotes(),
            ))
                .then((value) {
              setState(() {});
            });
          },
          backgroundColor: Colors.green[300],
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {

            if (snapshot.hasData) {

              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Random random = new Random();
                  Color bg = color[random.nextInt(color.length)];
                  Map? data = snapshot.data?.docs[index].data();
                  String title = "";
                  DateTime temp = DateTime.now();
                  String desc = "";

                  if (data != null) {
                    title += data['title'];
                    temp = data['timestamp'].toDate();
                    // dt = data['timestamp'].toDate();
                    desc += data['desc'];
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => ViewNote(
                                title,
                                desc,
                                temp,
                                snapshot.data!.docs[index].reference,
                              ),
                            ),
                          )
                          .then((value) => setState(() => {}));
                    },
                    child: Card(
                        color: bg,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$title",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(DateFormat.yMMMd()
                                      .add_jm()
                                      .format(temp))),
                            ],
                          ),
                        )),
                  );
                },
              );
            } else {
              return Center(
                  child: Text("Start saving your notes!....",
                      style: TextStyle(color: Colors.white)));
            }
          },
        ));
  }
}
