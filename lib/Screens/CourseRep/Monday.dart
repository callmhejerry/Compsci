import 'package:cloud_firestore/cloud_firestore.dart';
import 'Courserep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../ColorPalette.dart';

class Monday extends StatefulWidget {
  @override
  _MondayState createState() => _MondayState();
}

class _MondayState extends State<Monday> {
  TextEditingController _courseController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  addMondayTimetable(
      String course, String duration, String time, String venue) {
    Map<String, dynamic> data = {
      "Course": course,
      "Duration": duration,
      "Time": time,
      "Venue": venue,
      "timeStamp": DateTime.now()
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Monday");
    collectionReference.add(data);
  }

  CollectionReference monday = FirebaseFirestore.instance.collection("Monday");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: StreamBuilder(
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text("No internet connection"),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 12),
                  child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Classes1(
                      course: data["Course"],
                      duration: data["Duration"],
                      time: data["Time"],
                      venue: data["Venue"],
                      collectionReference: monday,
                      id: document.id,
                    );
                  }).toList()),
                ),
              );
            }
          }
          return Container();
        },
        stream: monday.orderBy("timeStamp").snapshots(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierColor: Colors.black.withOpacity(0.3),
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Add timetable'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      _key.currentState.save();

                      if (_key.currentState.validate()) {
                        addMondayTimetable(
                            _courseController.text,
                            _durationController.text,
                            _timeController.text,
                            _venueController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add'),
                  )
                ],
                scrollable: true,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                // backgroundColor: ColorPalette().bGColor,
                content: FormBuilder(
                  key: _key,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        controller: _courseController,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'Course',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Course",
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        thickness: 0.8,
                      ),
                      FormBuilderTextField(
                        controller: _durationController,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'Duration',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Duration",
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        thickness: 0.8,
                      ),
                      FormBuilderDateTimePicker(
                        controller: _timeController,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        inputType: InputType.time,
                        name: 'Time',
                        format: DateFormat("h:mma"),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Time",
                        ),
                      ),
                      Divider(
                        height: 0.5,
                        thickness: 0.8,
                      ),
                      FormBuilderTextField(
                        controller: _venueController,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        name: 'Venue',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Venue",
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorPalette().accentColor4,
      ),
    );
  }
}
