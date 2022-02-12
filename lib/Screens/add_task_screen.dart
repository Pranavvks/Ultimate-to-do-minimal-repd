import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repository/tasks_repository.dart';
import '../TasksBloc/tasks_bloc.dart';
import '../Model/daily_tasks.dart';
import 'package:uuid/uuid.dart';

class AddTasksScreen extends StatelessWidget {
  const AddTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksBloc>(
      create: (context) =>
          TasksBloc(dailytasksrepository: context.read<TasksRepository>()),
      child: Container(
        child: AddTasksScreenHelper(),
      ),
    );
  }
}

class AddTasksScreenHelper extends StatefulWidget {
  const AddTasksScreenHelper({Key? key}) : super(key: key);

  @override
  State<AddTasksScreenHelper> createState() => _AddTasksScreenHelperState();
}

class _AddTasksScreenHelperState extends State<AddTasksScreenHelper> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String tasktitle = "";
    var task;

    return Scaffold(
      backgroundColor: Color.fromRGBO(79, 116, 255, 1),
      floatingActionButton: InkWell(
        onTap: () => {
          BlocProvider.of<TasksBloc>(context).add(CreateEverydayTasks(task)),
        },
        child: SizedBox(
          child: Container(
            margin: EdgeInsets.only(right: 60, left: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 17, right: 4, left: 4),
                  child: Text(
                    "New Task",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            height: 60,
            width: 220,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 36, left: 105),
              child: TextField(
                controller: myController,
                onSubmitted: (value) => {
                  task = createTasks(value),
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(187, 196, 217, 1),
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                  hintText: "Enter task",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              )),
          Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 27),
                      child: Text(
                        "Today",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      margin: EdgeInsets.only(left: 8),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DailyTasks createTasks(
    String tasktitle,
  ) {
    var id = Uuid().v4();
    return DailyTasks(
      task_title: tasktitle,
      id: id,
    );
  }
}
