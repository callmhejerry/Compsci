import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compsci/Screens/Students/Assignment.dart';
import 'package:compsci/Screens/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../ColorPalette.dart';
import 'Monday.dart';
import 'Friday.dart';
import 'Tuesday.dart';
import 'Thursday.dart';
import 'Wednesday.dart';
import '../Students/Home.dart';

class CourseRepApp extends StatefulWidget {
  @override
  _CourseRepAppState createState() => _CourseRepAppState();
}

class _CourseRepAppState extends State<CourseRepApp> {
  List<Widget> screens = [
    CourseRepTimeTable(),
    CourseRepAssignment(),
    CourseRepAnnouncement()
  ];

  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette().bGColor,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: ColorPalette().accentColor4,
          unselectedItemColor: Colors.white,
          currentIndex: _selected,
          onTap: (index) {
            setState(() {
              _selected = index;
            });
          },
          backgroundColor: ColorPalette().bGColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Feather.calendar),
              label: "Timetable",
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.activity),
              label: 'Assignments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Feather.info),
              label: 'Announcements',
            ),
          ],
        ),
        body: screens[_selected],
      ),
    );
  }
}

class CourseRepTimeTable extends StatefulWidget {
  @override
  _CourseRepTimeTableState createState() => _CourseRepTimeTableState();
}

class _CourseRepTimeTableState extends State<CourseRepTimeTable> {
  List<Widget> tabs = [
    Text(
      'Mon',
    ),
    Text(
      'Tue',
    ),
    Text(
      'Wed',
    ),
    Text(
      'Thu',
    ),
    Text(
      'Fri',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: ColorPalette().bGColor,
        appBar: AppBar(
          title: Text('TimeTable'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Authchange authchange =
                      Provider.of<Authchange>(context, listen: false);
                  authchange.signOut();
                  Navigator.pop(context);
                })
          ],
          backgroundColor: ColorPalette().bGColor,
          elevation: 0,
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: ColorPalette().accentColor3,
            unselectedLabelColor: ColorPalette().accentColor4,
            labelStyle: TextStyle(
              fontSize: 20.00,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            labelPadding: EdgeInsets.only(bottom: 7),
            unselectedLabelStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Monday(),
            Tuesday(),
            Wednesday(),
            Thursday(),
            Friday(),
          ],
        ),
      ),
    );
  }
}

class CourseRepAssignment extends StatefulWidget {
  @override
  _CourseRepAssignmentState createState() => _CourseRepAssignmentState();
}

class _CourseRepAssignmentState extends State<CourseRepAssignment> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Assignments');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      appBar: AppBar(
        title: Text('Assignments'),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorPalette().bGColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette().accentColor4,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddAssignment(),
            ),
          );
        },
        child: Center(
            child: Text(
          '+',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: StreamBuilder(
          stream: collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
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
    );
  }
}

class CourseRepAnnouncement extends StatefulWidget {
  @override
  _CourseRepAnnouncementState createState() => _CourseRepAnnouncementState();
}

class _CourseRepAnnouncementState extends State<CourseRepAnnouncement> {
  Stream<QuerySnapshot> announcement =
      FirebaseFirestore.instance.collection("Annocements").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Annoucements"),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: ColorPalette().bGColor,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return AddAnnouncement();
                    },
                  ),
                );
              })
        ],
      ),
      backgroundColor: ColorPalette().bGColor,
      body: StreamBuilder(
        stream: announcement,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Somthing went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Info(
                    title: data["Title"],
                    text: data["Description"],
                  );
                }).toList(),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text('No Announcements yet'),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

class AddAnnouncement extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  announce(String title, String description) {
    Map<String, dynamic> data = {
      "Description": description,
      "Title": title,
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Annocements");
    collectionReference.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Fields cannot be empty";
                      }
                    },
                    maxLength: 30,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: TextStyle(
                        color: ColorPalette().accentColor4,
                        fontSize: 13,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: ColorPalette().accentColor4,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: ColorPalette().accentColor4,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLength: 120,
                    maxLines: 5,
                    minLines: 2,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Fields cannot be empty";
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(
                        color: ColorPalette().accentColor4,
                        fontSize: 13,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: ColorPalette().accentColor4,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: ColorPalette().accentColor4,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          ColorPalette().accentColor4),
                    ),
                    onPressed: () {
                      _key.currentState.save();
                      print(_descriptionController.text);
                      print(_titleController.text);
                      if (_key.currentState.validate()) {
                        announce(_titleController.value.text,
                            _descriptionController.value.text);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          )),
      appBar: AppBar(
        backgroundColor: ColorPalette().bGColor,
        title: Text(
          'Add Announcement',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Feather.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class AddAssignment extends StatelessWidget {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  addAssignment(
    String course,
    String details,
    String submissionDate,
  ) {
    Map<String, dynamic> data = {
      "course": course,
      "details": details,
      "submission date": submissionDate
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Assignments");

    collectionReference.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add assignment"),
        backgroundColor: ColorPalette().bGColor,
      ),
      backgroundColor: ColorPalette().bGColor,
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormBuilder(
              key: _key,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    controller: _courseController,
                    name: "Course",
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add course ",
                      contentPadding: EdgeInsets.only(left: 48),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 25),
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    controller: _detailsController,
                    name: "Details",
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Add details',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.short_text,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 25),
                  FormBuilderDateTimePicker(
                    controller: _dateController,
                    name: "Submission Date",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    alwaysUse24HourFormat: false,
                    format: DateFormat("EEEE,MMMM d, yyyy 'at' h:mma"),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    initialDate: DateTime.now(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add submission date",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Feather.calendar,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        _key.currentState.save();
                        if (_key.currentState.validate()) {
                          addAssignment(
                            _courseController.text,
                            _detailsController.text,
                            _dateController.text,
                          );
                          print('sucess');
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Add'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class Classes1 extends StatefulWidget {
  const Classes1({
    this.course,
    this.duration,
    this.time,
    this.venue,
    this.collectionReference,
    this.id,
  });
  final String course;
  final String venue;
  final String time;
  final String duration;
  final CollectionReference collectionReference;
  final String id;
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes1> {
  TextEditingController courseController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print(widget.course);
        showDialog(
            barrierColor: Colors.black.withOpacity(0.3),
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Update TimeTable'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> data = {
                          "Course": courseController.text,
                          "Duration": durationController.text,
                          "Time": timeController.text,
                          "Venue": venueController.text
                        };
                        widget.collectionReference.doc(widget.id).update(data);
                        Navigator.pop(context);
                      },
                      child: Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.collectionReference.doc(widget.id).delete();
                        Navigator.pop(context);
                      },
                      child: Text('Delete'),
                    )
                  ],
                  scrollable: true,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // backgroundColor: ColorPalette().bGColor,
                  content: FormBuilder(
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          controller: courseController,
                          // initialValue: courseController.value.text,
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
                          // initialValue: widget.duration,
                          controller: durationController,
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
                          controller: timeController,
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
                          // initialValue: widget.venue,
                          controller: venueController,
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
                ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.book,
                  size: 21,
                ),
                SizedBox(width: 7),
                Text(
                  'Course:  ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.course),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  size: 21,
                ),
                SizedBox(width: 7),
                Text(
                  "Duration:  ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.duration),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Feather.clock,
                  size: 21,
                ),
                SizedBox(width: 7),
                Text(
                  "Time:  ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.time),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.place,
                  size: 21,
                ),
                SizedBox(width: 7),
                Text(
                  "Venue:  ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(widget.venue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
