part of 'tasks_bloc.dart';

enum TodoStatus { initial, loading, success, failure }

abstract class TodosState extends Equatable {}

class DisplayTodoState extends TodosState {
  DisplayTodoState({
    this.status = TodoStatus.initial,
    this.daily_tasks,
  });

  final TodoStatus status;
  final BehaviorSubject<DocumentSnapshot<Map<String, dynamic>>>? daily_tasks;

  DisplayTodoState copyWith({
    TodoStatus? status,
    BehaviorSubject<DocumentSnapshot<Map<String, dynamic>>>? daily_tasks,
  }) {
    return DisplayTodoState(
      status: status ?? this.status,
      daily_tasks: this.daily_tasks,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, daily_tasks];
}
