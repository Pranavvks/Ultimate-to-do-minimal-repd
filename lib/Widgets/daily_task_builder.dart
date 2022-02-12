import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Model/daily_tasks.dart';
import './custom_category_buttons.dart';

class DailyTaskBuilder extends StatefulWidget {
  DailyTaskBuilder({
    required this.dailytaskslist,
    Key? key,
  }) : super(key: key);
  StreamController<DocumentSnapshot<Map<String, dynamic>>>? dailytaskslist;

  @override
  State<DailyTaskBuilder> createState() => _DailyTaskBuilderState();
}

class _DailyTaskBuilderState extends State<DailyTaskBuilder> {
  // List<DailyTaskBuilderUI> daily_tasks = [];

  @override
  Widget build(BuildContext context) {
    List<DailyTasks> x = [];
    var datastream = widget.dailytaskslist!.stream.listen;

    return StreamBuilder(
      stream: widget.dailytaskslist!.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: x.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xff0A155A),
                  child: Container(
                    margin: EdgeInsets.all(6),
                    width: 270,
                    height: 65,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 14, right: 10, bottom: 20),
                                child: CustomPaint(
                                  painter:
                                      TaskButtonPainter(color: Colors.green),
                                )),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 20, right: 0, left: 30, bottom: 20),
                                child: Text(
                                  x[index].task_title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}
