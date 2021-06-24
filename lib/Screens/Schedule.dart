import 'package:compsci/ColorPalette.dart';
import 'package:compsci/Screens/api.dart';
// import 'package:compsci/Screens/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Addtaask.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // List<Task> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: ColorPalette().bGColor,
        title: Text(
          'Schedule',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: ColorPalette().bGColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette().accentColor4,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Addtask()));
        },
        child: Text(
          "+",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<AddSchedule>(
        child: Text('good'),
        builder: (context, task, child) {
          List<Task> tasks = task.tasks;
          if (tasks.isEmpty) {
            return Center(
              child: Text(
                'No schedule yet',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 10,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(children: tasks),
              ),
            );
          }
        },
      ),
    );
  }
}

class Task extends StatefulWidget {
  const Task({
    @required this.uuid,
    @required this.taskwork,
    @required this.title,
  });

  final String taskwork;
  final String title;
  final String uuid;

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool done = false;
  bool overflow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          overflow = !overflow;
        });
      },
      onLongPress: () {
        showDialog(
          useSafeArea: true,
          barrierColor: Colors.black.withOpacity(0.3),
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 5,
              backgroundColor: ColorPalette().bGColor,
              title: Text(
                'Edit task',
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                'You can choose to remove the task or mark as done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        AddSchedule task =
                            Provider.of<AddSchedule>(context, listen: false);

                        task.removeSchedule(widget.uuid);
                        print(widget.uuid);
                        print(task.tasks.length);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            done = !done;
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        done ? 'Undo' : 'Done',
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorPalette().accentColor4,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.taskwork,
                  overflow:
                      overflow ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
        height: overflow ? null : 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: done ? Colors.transparent : Colors.black26,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
