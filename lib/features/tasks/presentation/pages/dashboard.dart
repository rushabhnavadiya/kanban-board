import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';
import 'package:take_home_challenge_innoscripta/core/utils/injections.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/add_new_comment_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/add_new_task_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/get_comments_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/update_status_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/pages/history_page.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/pages/home_page.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/add_task_bottom_sheet.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const route = '/dashboard';
  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List<TaskModel> taskList = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => TasksBloc(
          sl<AddNewTaskUseCase>(),
          sl<GetTasksUseCase>(),
          sl<UpdateTaskUseCase>(),
          sl<UpdateStatusTaskUseCase>(),
          sl<DeleteTaskUseCase>(),
          sl<AddNewCommentUseCase>(),
          sl<GetCommentsUseCase>(),
        )..add(
          const GetTasksEvent(),
        ),
        child: BlocListener<TasksBloc, TasksState>(
          listener: (context, state) {
            if(state is TaskLoaded) {
              taskList.clear();
              taskList.addAll(state.tasks);
            }
            if(state is TaskAdded) {
              taskList.clear();
              taskList.addAll(state.tasks);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task Added Successfully'),
                ),
              );
            }
            if(state is TaskUpdated) {
              taskList.clear();
              taskList.addAll(state.tasks);
            }
          },
          child: Builder(
            builder: (context) {
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.darkBlue,
                    centerTitle: false,
                    title: Text(
                      "Dashboard",
                      style: AppTextStyle.xxxLargeBlackBold.copyWith(fontSize: 20,color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    actions: [
                      TextButton(
                          onPressed: (){
                            showModalBottomSheet<dynamic>(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                              ),
                              isScrollControlled: true,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: context.read<TasksBloc>(),
                                  child: AddTaskBottomSheet(
                                    onSave: () {},
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(" + Add Task  ",
                            style: AppTextStyle.largeBlack.copyWith(color: Colors.white),)
                      )
                      // IconButton(
                      //   onPressed: () => context.read<TaskBloc>().add(
                      //     const DownloadTaskEvent(),
                      //   ),
                      //   icon: const Icon(
                      //     Icons.download,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      // DropdownButton<Language>(
                      //   onChanged: (Language? language) {
                      //     context.read<LocalizationBloc>().add(
                      //       ChangeLocalizationEvent(
                      //         language?.languageCode ?? 'en',
                      //       ),
                      //     );
                      //   },
                      //   icon: const Icon(
                      //     Icons.language,
                      //     color: Colors.white,
                      //   ),
                      //   items: Language.languageList()
                      //       .map<DropdownMenuItem<Language>>(
                      //         (e) => DropdownMenuItem<Language>(
                      //       value: e,
                      //       child: Text(e.name),
                      //     ),
                      //   )
                      //       .toList(),
                      // ),
                    ],
                  ),
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      HomePage(tasks: taskList),
                      HistoryPage(tasks: taskList),
                    ],
                  ),

                  /*floatingActionButton: FloatingActionButton(
                    backgroundColor: AppColors.darkBlue,
                    onPressed: () {
                      showModalBottomSheet<dynamic>(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                        ),
                        isScrollControlled: true,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<TasksBloc>(),
                            child: AddTaskBottomSheet(
                              onSave: () {},
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.add,
                      size: 30,
                    ),
                  ),*/
                  bottomNavigationBar: Container(
                    color: AppColors.darkBlue,
                    child: TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white70,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(CupertinoIcons.home, size: 18.h,),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 2.w),
                                child: const Text(
                                  'Home',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.history, size: 18.h,),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 2.w),
                                child: const Text(
                                  'History',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}