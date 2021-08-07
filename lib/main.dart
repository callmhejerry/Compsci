import 'package:compsci/ColorPalette.dart';
import 'package:compsci/Screens/CourseRep/Courserep.dart';
// import 'package:compsci/Screens/Addtaask.dart';
import 'package:compsci/Screens/Students/Home.dart';
import 'package:compsci/Screens/api.dart';
import 'package:compsci/Screens/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'Screens/Students/Assignment.dart';
import 'Screens/Students/Schedule.dart';
import 'Screens/Students/Timetable.dart';

import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessage);
  runApp(MyApp());
}

Future<void> backgroundMessage(RemoteMessage message) async {
  return Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddSchedule()),
        ChangeNotifierProvider(create: (_) => Authchange()),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          shadowColor: Colors.black.withOpacity(0.3),
          fontFamily: 'Poppins',
          backgroundColor: ColorPalette().bGColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorPalette().accentColor4),
            ),
          ),
          buttonColor: ColorPalette().accentColor4,
        ),
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new Controller(),
      image: Image.asset("assets/icon.JPG"),
      backgroundColor: ColorPalette().bGColor,
      photoSize: 100.0,
      loadingText: Text(
        "Hi5ive Tech",
        style: TextStyle(
          color: Colors.blueAccent,
          fontFamily: "Poppins",
          fontSize: 18,
        ),
      ),
      useLoader: false,
      title: Text(
        "CompSci",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}

class Controller extends StatefulWidget {
  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: UserAuth().firebaseAuth.idTokenChanges(),
      builder: (context, AsyncSnapshot<User> user) {
        if (user.connectionState == ConnectionState.active) {
          if (user.data != null) {
            if (user.data.uid == 'ZrsrNH9F7FXuGDqUSTNbi6zd6te2') {
              return CourseRepApp();
            }
            return Home();
          }
        }
        return LoginScreen();
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  StreamSubscription _foregroundmsg;

  @override
  void initState() {
    _foregroundmsg =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      SnackBar snackBar = SnackBar(
        content: Text(
          message.notification.title,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _foregroundmsg.cancel();
  }

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
              icon: Icon(Feather.clock, size: 20), label: 'Timetable'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book, size: 20), label: 'Assignment'),
          BottomNavigationBarItem(
              icon: Icon(Feather.calendar, size: 20), label: 'Schedule'),
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
