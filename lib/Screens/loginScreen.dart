import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compsci/Screens/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../ColorPalette.dart';
import 'CourseRep/Courserep.dart';

final UserAuth auth = UserAuth();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _surname = TextEditingController();
  TextEditingController _regNumber = TextEditingController();
  GlobalKey<FormState> studentFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: Padding(
        child: Form(
          key: studentFormKey,
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
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Field cannot be empty';
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Feather.user,
                    color: ColorPalette().accentColor4,
                    size: 21,
                  ),
                  hintText: 'Class email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
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
                // ignore: missing_return
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Field cannot be empty';
                  }
                },
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Feather.lock,
                    color: ColorPalette().accentColor4,
                    size: 20,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
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
                onTap: () async {
                  studentFormKey.currentState.save();
                  if (studentFormKey.currentState.validate()) {
                    try {
                      UserCredential userCredential = await auth.studentSignin(
                          _surname.text, _regNumber.text);
                      String fcmToken =
                          await FirebaseMessaging.instance.getToken();
                      print(fcmToken);
                      DocumentReference tokenRef = FirebaseFirestore.instance
                          .collection('Users')
                          .doc('user tokens')
                          .collection('tokens')
                          .doc(fcmToken);

                      await tokenRef.set({
                        'token': fcmToken,
                        'regnumber': _regNumber.text,
                        'name': _surname.text,
                        'device': Platform.operatingSystem,
                      });

                      if (userCredential != null) {
                        _surname.clear();
                        _regNumber.clear();
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = e.message.toString();
                      print(errorMessage);
                      SnackBar snackBar = SnackBar(
                        content: Text(errorMessage),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CourseRepLogin())),
                  child: Text(
                    "Log in as a course rep",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
      ),
    );
  }
}

class CourseRepLogin extends StatefulWidget {
  @override
  _CourseRepLoginState createState() => _CourseRepLoginState();
}

class _CourseRepLoginState extends State<CourseRepLogin> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> courseRepFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette().bGColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Feather.arrow_left),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: ColorPalette().bGColor,
          elevation: 0,
          title: Text('course rep'),
        ),
        body: Padding(
          child: Form(
            key: courseRepFormKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Field cannot be empty";
                    }
                  },
                  controller: _username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Feather.user,
                      color: ColorPalette().accentColor4,
                      size: 21,
                    ),
                    hintText: 'User name ',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
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
                  controller: _password,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Field cannot be empty";
                    }
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Feather.lock,
                      color: ColorPalette().accentColor4,
                      size: 20,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    hintText: 'Password',
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
                  onTap: () async {
                    courseRepFormKey.currentState.save();
                    if (courseRepFormKey.currentState.validate()) {
                      try {
                        UserCredential user = await auth.courseRepSignIn(
                            _username.text, _password.text);
                        String fcmToken =
                            await FirebaseMessaging.instance.getToken();
                        print(fcmToken);
                        DocumentReference tokenRef = FirebaseFirestore.instance
                            .collection('Users')
                            .doc('user tokens')
                            .collection('tokens')
                            .doc(fcmToken);

                        await tokenRef.set({
                          'token': fcmToken,
                          'regnumber': _username.text,
                          'name': _password.text,
                          'device': Platform.operatingSystem,
                        });
                        if (user.user.uid == "ZrsrNH9F7FXuGDqUSTNbi6zd6te2") {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CourseRepApp(),
                              ));
                        } else {
                          SnackBar snackBar = SnackBar(
                            content: Text(
                                "please login with the correct course rep credentials"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } on FirebaseAuthException catch (e) {
                        SnackBar snackBar = SnackBar(content: Text(e.message));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30),
        ),
      ),
    );
  }
}
