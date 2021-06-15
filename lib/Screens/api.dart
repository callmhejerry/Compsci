import 'package:compsci/Screens/Schedule.dart';
import 'package:flutter/widgets.dart';

class AddSchedule extends ChangeNotifier {
  Key key = GlobalKey();
  List<Task> tasks = [];
  addSchedule(String title, String taskwork) {
    tasks.add(
      Task(
        taskwork: taskwork,
        title: title,
        key: key,
      ),
    );
    notifyListeners();
  }

  removeSchedule(Task task) {
    tasks.remove(task.key);
    notifyListeners();
  }
}
