import 'package:compsci/ColorPalette.dart';
import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<Assignment> assignments = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().bGColor,
      body: assignments.isEmpty
          ? Center(
              child: Text(
                'No assignments',
                style: TextStyle(color: Colors.white),
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: assignments,
              ),
            ),
      appBar: AppBar(
        backgroundColor: ColorPalette().bGColor,
        title: Text(
          'Assignments',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class Assignment extends StatefulWidget {
  Assignment({this.course, this.details, this.submissionDate});
  final String details;
  final String course;
  final String submissionDate;
  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
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
                  'Edit Assignment',
                  style: TextStyle(color: Colors.white),
                ),
                content: Text(
                  'Have you done your assignment ?',
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
                      // TextButton(
                      //     onPressed: null,
                      //     child: Text(
                      //       'Remove',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.black,
                      //       ),
                      //     )),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            done = !done;
                          });
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
            });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.course,
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
                child: Text(
                  widget.details,
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
              height: 6,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Submission:  ' + widget.submissionDate,
                    style: TextStyle(
                      color: ColorPalette().accentColor4,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    DateTime.now().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ],
              )),
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
