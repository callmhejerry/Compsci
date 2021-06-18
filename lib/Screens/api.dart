import 'package:compsci/Screens/Schedule.dart';
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
