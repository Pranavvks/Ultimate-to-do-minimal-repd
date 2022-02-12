import 'dart:async';
import './daily_todo_api_db.dart';
import '../Model/daily_tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class TasksRepository {
  const TasksRepository({
    required DailyTodoApiDb dailyTodoApiDb,
  }) : dailyTodosApiDb = dailyTodoApiDb;

  final DailyTodoApiDb dailyTodosApiDb;

  BehaviorSubject<DocumentSnapshot<Map<String, dynamic>>> getDailyTodos() =>
      dailyTodosApiDb.getDailyTasks();
  Future<void> createdDailyTodo(DailyTasks task) =>
      dailyTodosApiDb.CreateDailyTask(task);
}
