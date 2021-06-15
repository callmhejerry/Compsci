import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../ColorPalette.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _surname = TextEditingController();
  TextEditingController _regNumber = TextEditingController();
  Route _routeHomeScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Home(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: Padding(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Log in ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: _surname,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Feather.user,
                  color: Colors.white,
                  size: 21,
                ),
                hintText: 'Surname',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _regNumber,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Feather.lock,
                  color: Colors.white,
                  size: 20,
                ),
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                hintText: 'Reg number',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, _routeHomeScreen());
              },
              child: Container(
                height: 55,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Log in ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: ColorPalette().accentColor4,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.black,
                      offset: Offset(0.00, 0.00),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
      ),
    );
  }
}
