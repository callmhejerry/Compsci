import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:table_calendar/table_calendar.dart';
import '../ColorPalette.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Feather.menu), onPressed: () {}),
        ],
        backgroundColor: ColorPalette().bGColor,
        elevation: 0,
        title: Text(
          'CompSci',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TableCalendar(
                firstDay: DateTime(2021, 1, 7),
                availableGestures: AvailableGestures.horizontalSwipe,
                availableCalendarFormats: {
                  CalendarFormat.month: 'month',
                },
                calendarFormat: CalendarFormat.month,
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
                focusedDay: DateTime.now(),
                lastDay: DateTime(2080, 9, 7),
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  outsideDaysVisible: false,
                  isTodayHighlighted: true,
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
            Info(),
            Info(),
            Info(),
            Info(),
            Info(),
            Info(),
          ],
        ),
      ),
    );
  }
}

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool overflow = false;
  String text =
      'Maths 101 assignments need to be submitted on the fourth of march in order to avoid any hindrances please speak to thwe assistant course rep';
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
        'Assignment',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        text,
        overflow: overflow ? TextOverflow.visible : TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
