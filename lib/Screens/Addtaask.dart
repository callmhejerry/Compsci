import 'package:compsci/ColorPalette.dart';
import 'package:compsci/Screens/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Addtask extends StatefulWidget {
  // final List<Task> task;
  // Addtask(this.task);
  @override
  _AddtaskState createState() => _AddtaskState();
}

class _AddtaskState extends State<Addtask> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 8),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                maxLength: 20,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: ColorPalette().accentColor4,
                    fontSize: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: ColorPalette().accentColor4,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: ColorPalette().accentColor4,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLength: 120,
                maxLines: 5,
                minLines: 2,
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(
                    color: ColorPalette().accentColor4,
                    fontSize: 13,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: ColorPalette().accentColor4,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: ColorPalette().accentColor4,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorPalette().accentColor4),
                ),
                onPressed: () {
                  Provider.of<AddSchedule>(context, listen: false)
                      .addSchedule(_titleController.text, _taskController.text);

                  print(
                    Provider.of<AddSchedule>(context, listen: false)
                        .tasks
                        .length,
                  );
                  Navigator.pop(context);
                },
                child: Text('Add'),
              ),
            ],
          )),
      appBar: AppBar(
        backgroundColor: ColorPalette().bGColor,
        title: Text(
          'Add task',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Feather.arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
