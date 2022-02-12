import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../TasksBloc/tasks_bloc.dart';
import '../Repository/tasks_repository.dart';
import '../Widgets/daily_task_builder.dart';
import './add_task_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TasksBloc(dailytasksrepository: context.read<TasksRepository>())
            ..add(LoadEverydayTasks()),
      child: NewHomeScreen(),
    );
  }
}

class NewHomeScreen extends StatelessWidget {
  NewHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffD103FC),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTasksScreen()),
          );
        },
      ),
      backgroundColor: Color(0xff4F74FF),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 27.0,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 27.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 27.0,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  child: Text(
                    "What's up user !",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800),
                  ),
                  margin: EdgeInsets.only(left: 48, top: 10, right: 48)),
              Container(
                padding: EdgeInsets.only(bottom: 1, left: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "TODAY'S TASKS",
                        style: TextStyle(
                            color: Color(0xffBBC2D8),
                            fontWeight: FontWeight.w900),
                      ),
                      margin: EdgeInsets.only(right: 240, bottom: 20),
                    ),
                    BlocBuilder<TasksBloc, DisplayTodoState>(
                      bloc: BlocProvider.of<TasksBloc>(context),
                      builder: (context, state) {
                        if (state.status == TodoStatus.failure) {
                          return Center(
                            child:
                                Text("No tasks for the day.Tap the add button"),
                          );
                        }
                        if (state.status == TodoStatus.success)
                          return DailyTaskBuilder(
                              dailytaskslist: state.daily_tasks);
                        else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
