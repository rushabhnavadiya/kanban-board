import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/task_class_widget.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/task_tile.dart';

class HistoryPage extends StatelessWidget {
  final List<TaskModel> tasks;
  const HistoryPage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<TasksBloc, TasksState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TaskClass(
                title: "Completed Tasks",
                width: MediaQuery.of(context).size.width,
                child: Builder(
                  builder: (context) {
                    final doneTasks = tasks
                        .where(
                          (task) => task.sectionId == doneSectionID,
                    ).toList();
                    return SingleChildScrollView(

                      child: Column(
                        children: List.generate(
                          doneTasks.length,
                              (index) {
                            final task = doneTasks[index];
                            return TaskTile(
                              task: task,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _convertSecondsToTimeString(int seconds) {
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}'
        ': ${(seconds % 60).toString().padLeft(2, '0')}';
  }
}