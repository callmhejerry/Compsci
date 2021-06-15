import 'package:compsci/ColorPalette.dart';
// import 'package:compsci/Screens/Addtaask.dart';
import 'package:compsci/Screens/Home.dart';
import 'package:compsci/Screens/api.dart';
import 'package:compsci/Screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'Screens/Assignment.dart';
import 'Screens/Schedule.dart';
import 'Screens/Timetable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddSchedule()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          backgroundColor: ColorPalette().bGColor,
          buttonColor: ColorPalette().accentColor4,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      TimetablePage(),
      AssignmentPage(),
      SchedulePage(),
    ];
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Feather.home, size: 20), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 20), label: 'Timetable'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 20), label: 'Assignment'),
          BottomNavigationBarItem(
              icon: Icon(Feather.clock, size: 20), label: 'Schedule'),
        ],
        backgroundColor: ColorPalette().bGColor,
        elevation: 0,
        currentIndex: selected,
        selectedItemColor: ColorPalette().accentColor3,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (val) => {
          setState(() {
            selected = val;
          })
        },
      ),
      body: screens[selected],
    );
  }
}
