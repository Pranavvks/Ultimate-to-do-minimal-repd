import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../Repository/tasks_repository.dart';
import '../Model/daily_tasks.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, DisplayTodoState> {
  final TasksRepository dailytasksrepository;

  TasksBloc({
    required TasksRepository this.dailytasksrepository,
  }) : super(DisplayTodoState()) {
    on<LoadEverydayTasks>((event, emit) async {
      emit(state.copyWith(status: TodoStatus.loading));
      var x = dailytasksrepository.getDailyTodos();
      emit(state.copyWith(daily_tasks: x, status: TodoStatus.success));
    });

    on<CreateEverydayTasks>(_CreateTodo);
  }
  Future<void> _CreateTodo(
    CreateEverydayTasks event,
    Emitter<DisplayTodoState> emit,
  ) async {
    var x = await dailytasksrepository.createdDailyTodo(event.task);
  }
}
