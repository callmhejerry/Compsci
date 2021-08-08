import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compsci/ColorPalette.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignmentPage extends StatefulWidget {
  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Assignments');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: StreamBuilder(
          stream: collectionReference
              .orderBy("timeStamp", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Assignment(
                      course: data["course"],
                      details: data["details"],
                      submissionDate: data["submission date"],
                    );
                  }).toList(),
                ),
              );
            }
            return Container();
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorPalette().bGColor,
        title: Text(
          'Assignments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class Assignment extends StatefulWidget {
  Assignment({this.course, this.details, this.submissionDate});
  final String details;
  final String course;
  final String submissionDate;
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  bool done = false;
  bool overflow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          overflow = !overflow;
        });
      },
      onLongPress: () {
        showDialog(
          useSafeArea: true,
          barrierColor: Colors.black.withOpacity(0.3),
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              backgroundColor: ColorPalette().bGColor,
              title: Text(
                'Edit Assignment',
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'Have you done your assignment ?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          done = !done;
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        done ? 'Undo' : 'Done',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorPalette().accentColor4,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.course,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: Text(
                  widget.details,
                  overflow:
                      overflow ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Submission:  ' + widget.submissionDate,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 13,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      DateFormat.yMd().format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
        height: overflow ? null : 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: done ? Colors.transparent : Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
