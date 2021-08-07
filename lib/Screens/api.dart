import 'package:compsci/Screens/Students/Schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class AddSchedule extends ChangeNotifier {
  Uuid uuid = Uuid();
  List<Task> tasks = [];

  addSchedule(String title, String taskwork) {
    tasks.add(
      Task(
        taskwork: taskwork,
        title: title,
        uuid: uuid.v4(),
      ),
    );
    notifyListeners();
  }

  removeSchedule(String uuid) {
    tasks.removeWhere((element) => element.uuid == uuid);
    // tasks.forEach((element) {
    //   tasks.remove(element.uuid);
    // });
    notifyListeners();
  }
}

class UserAuth {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> studentSignin(String surname, String regnumber) async {
    // UserCredential studentCredential =

    return firebaseAuth.signInWithEmailAndPassword(
        email: surname, password: regnumber);
  }

  Future<UserCredential> courseRepSignIn(String username, String password) {
    return firebaseAuth.signInWithEmailAndPassword(
        email: username, password: password);
  }
}

class Authchange extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool signedOut = false;
  User get currentUser => firebaseAuth.currentUser;
  signOut() async {
    try {
      await firebaseAuth.signOut();
      print("signed out");
      signedOut = !signedOut;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
