import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewNote extends StatefulWidget {
  // final Map? data;
  final String title;
  final String desc;
  final DocumentReference ref;
  final DateTime date;

  ViewNote(this.title, this.desc, this.date, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    // String s = widget.data?['title'];
    // print(s);
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deletes();
        },
        child: Icon(Icons.delete_forever),
        backgroundColor: Colors.red[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${widget.title}",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(widget.date),
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "${widget.desc}",
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    ));
  }

  void deletes() async {
    widget.ref.delete();

    Navigator.pop(context);
  }
}
