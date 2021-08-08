import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../ColorPalette.dart';
import '../api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Stream<QuerySnapshot> announcement = FirebaseFirestore.instance
      .collection("Annocements")
      .orderBy("timeStamp", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Feather.log_out),
              onPressed: () {
                Authchange authchange =
                    Provider.of<Authchange>(context, listen: false);
                authchange.signOut();
              }),
        ],
        backgroundColor: ColorPalette().bGColor,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'CompSci',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              " (Hi5ive Tech)",
              style: TextStyle(fontSize: 12.5, color: Colors.blueAccent),
            )
          ],
        ),
      ),
      body: StreamBuilder(
          stream: announcement,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TableCalendar(
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      firstDay: DateTime(1990, 10, 16),
                      lastDay: DateTime(2050, 3, 14),
                      focusedDay: _focusedDay,
                      availableGestures: AvailableGestures.horizontalSwipe,
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (CalendarFormat format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                      },
                      headerStyle: HeaderStyle(
                        titleTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        formatButtonVisible: true,
                        rightChevronVisible: true,
                        leftChevronVisible: true,
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      onDaySelected:
                          (DateTime selectedDay, DateTime focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                          _selectedDay = selectedDay;
                        });
                        print(_focusedDay);
                      },
                      selectedDayPredicate: (DateTime day) {
                        return isSameDay(_selectedDay, day);
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange,
                            width: 1,
                          ),
                        ),
                        defaultTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                        outsideDaysVisible: false,
                        todayDecoration: BoxDecoration(
                          color: ColorPalette().accentColor3,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.blue,
                        ),
                        todayTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      weekendDays: [
                        DateTime.saturday,
                        DateTime.sunday,
                      ],
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  snapshot.hasData
                      ? Column(
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return Info(
                              title: data["Title"],
                              text: data["Description"],
                            );
                          }).toList(),
                        )
                      : Center(
                          child: Text(
                            'No Announcements yet',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              ),
            );
          }),
    );
  }
}

class Info extends StatefulWidget {
  const Info({@required this.text, @required this.title});
  final String text;
  final String title;
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool overflow = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => setState(() {
        overflow = !overflow;
      }),
      isThreeLine: true,
      trailing: Icon(
        Feather.info,
        color: ColorPalette().accentColor3,
      ),
      // leading: Text(
      //   'Maths 101',
      //   style: TextStyle(color: Colors.white),
      // ),
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        widget.text,
        overflow: overflow ? TextOverflow.visible : TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
