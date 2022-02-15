import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../Model/daily_tasks.dart';

class DailyTodoApiDb {
  final todoStreamController =
      BehaviorSubject<DocumentSnapshot<Map<String, dynamic>>>();

  var anonymoususer;
  var db = FirebaseFirestore.instance;
  List<DailyTasks> x = [];

  Future<void> createUser() async {
    //FirebaseAuth.instance.signInAnonymously();
    if(FirebaseAuth.instance.currentUser != null)
    anonymoususer =  FirebaseAuth.instance.signInAnonymously();
    else
      anonymoususer = FirebaseAuth.instance.currentUser;
  }

  BehaviorSubject<DocumentSnapshot<Map<String, dynamic>>> getDailyTasks() {
    var stream =
        db.collection("Daily_tasks").doc(anonymoususer.user!.uid).snapshots();

    (stream.listen((event) {
      print(event.data());
    }));

    todoStreamController.sink.addStream(stream);

    return todoStreamController;
  }

  Future<void> CreateDailyTask(DailyTasks task) async {
    createUser();
    var increment = await db
        .collection("Daily_tasks")
        .doc(anonymoususer.user!.uid)
        .collection("Todo-count")
        .doc(anonymoususer.user!.uid)
        .update({"count": FieldValue.increment(1)}).onError((_, __) async =>
            await db
                .collection("Daily_tasks")
                .doc(anonymoususer.user!.uid)
                .collection("Todo-count")
                .doc(anonymoususer.user!.uid)
                .set({"count": FieldValue.increment(1)}));

    var response;

    var doc = await db
        .collection("Daily_tasks")
        .doc(anonymoususer.user!.uid)
        .collection("Todo-count")
        .where("count", isGreaterThanOrEqualTo: 1)
        .get()
        .then((value) => value.docs.forEach((element) {
              response = element.data();
            }));

    int count = response["count"];

    if (count == 1) {
      await db.collection("Daily_tasks").doc(anonymoususer.user!.uid).set({
        "_id": anonymoususer.user!.uid,
        "Tasks": [
          {
            "id": task.id,
            "task_title": task.task_title,
            "description": "",
            "isCompleted": false,
          }
        ]
      }).whenComplete(() => getDailyTasks());
    } else {
      var x = [
        {
          "id": task.id,
          "task_title": task.task_title,
          "description": "",
          "isCompleted": false,
        }
      ];

      await db
          .collection("Daily_tasks")
          .doc(anonymoususer.user!.uid)
          .update({"Tasks": FieldValue.arrayUnion(x)}).whenComplete(
              () => getDailyTasks());
    }
  }
}
