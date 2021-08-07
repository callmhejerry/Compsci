import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compsci/ColorPalette.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
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
          title: Text(
            'Timetable',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
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

class Tabview extends StatefulWidget {
  @override
  _TabviewState createState() => _TabviewState();
}

class _TabviewState extends State<Tabview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPalette().bGColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20),
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}

class Monday extends StatefulWidget {
  @override
  _MondayState createState() => _MondayState();
}

class _MondayState extends State<Monday> {
  CollectionReference monday = FirebaseFirestore.instance.collection("Monday");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
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
                // reverse: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 20),
                  child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Classes(
                      course: data["Course"],
                      duration: data["Duration"],
                      time: data["Time"],
                      venue: data["Venue"],
                    );
                  }).toList()),
                ),
              );
            }
          }
          return Container();
        },
        stream: monday.snapshots(),
      ),
    );
  }
}

class Tuesday extends StatefulWidget {
  @override
  _TuesdayState createState() => _TuesdayState();
}

class _TuesdayState extends State<Tuesday> {
  CollectionReference tuesday =
      FirebaseFirestore.instance.collection("Tuesday");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
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
                // reverse: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 20),
                  child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Classes(
                      course: data["Course"],
                      duration: data["Duration"],
                      time: data["Time"],
                      venue: data["Venue"],
                    );
                  }).toList()),
                ),
              );
            }
          }
          return Container();
        },
        stream: tuesday.snapshots(),
      ),
    );
  }
}

class Wednesday extends StatefulWidget {
  @override
  _WednesdayState createState() => _WednesdayState();
}

class _WednesdayState extends State<Wednesday> {
  CollectionReference wednesday =
      FirebaseFirestore.instance.collection("Wednesday");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
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
                // reverse: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 20),
                  child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Classes(
                      course: data["Course"],
                      duration: data["Duration"],
                      time: data["Time"],
                      venue: data["Venue"],
                    );
                  }).toList()),
                ),
              );
            }
          }
          return Container();
        },
        stream: wednesday.snapshots(),
      ),
    );
  }
}

class Thursday extends StatefulWidget {
  @override
  _ThursdayState createState() => _ThursdayState();
}

class _ThursdayState extends State<Thursday> {
  CollectionReference thursday =
      FirebaseFirestore.instance.collection("Thursday");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
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
                reverse: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 20),
                  child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Classes(
                      course: data["Course"],
                      duration: data["Duration"],
                      time: data["Time"],
                      venue: data["Venue"],
                    );
                  }).toList()),
                ),
              );
            }
          }
          return Container();
        },
        stream: thursday.snapshots(),
      ),
    );
  }
}

class Friday extends StatefulWidget {
  @override
  _FridayState createState() => _FridayState();
}

class _FridayState extends State<Friday> {
  CollectionReference friday = FirebaseFirestore.instance.collection("Friday");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
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
                reverse: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 20),
                  child: Column(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Classes(
                      course: data["Course"],
                      duration: data["Duration"],
                      time: data["Time"],
                      venue: data["Venue"],
                    );
                  }).toList()),
                ),
              );
            }
          }
          return Container();
        },
        stream: friday.snapshots(),
      ),
    );
  }
}

class Classes extends StatelessWidget {
  final String time;
  final String course;
  final String venue;
  final String duration;

  const Classes({this.course, this.duration, this.time, this.venue});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            child: Text(
              time,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: 36,
          ),
          Column(
            children: [
              Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: ColorPalette().accentColor3, width: 3),
                ),
                child: Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette().accentColor3,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 21.5,
              ),
              Container(
                width: 2,
                height: 82,
                color: ColorPalette().accentColor3,
              ),
            ],
          ),
          SizedBox(
            width: 36,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(
                height: 21.5,
              ),
              Text(
                venue,
                style: TextStyle(
                  color: Colors.white.withAlpha(170),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                duration,
                style: TextStyle(
                  color: Colors.white.withAlpha(170),
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 19,
      )
    ]);
  }
}
