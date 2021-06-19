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
            Tabview(),
            Tabview(),
            Tabview(),
            Tabview(),
            Tabview(),
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
            children: [
              Classes(
                course: 'Bio101',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
              Classes(
                course: 'mat102',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
              Classes(
                course: 'Chem223',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
              Classes(
                course: 'Bio101',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
              Classes(
                course: 'Bio101',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
              Classes(
                course: 'Bio101',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
              Classes(
                course: 'Bio101',
                duration: '2hrs',
                time: '8:00am',
                venue: 'stat hall',
              ),
            ],
          ),
        ),
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
          Text(
            time,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
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
