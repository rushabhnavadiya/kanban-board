import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_text_style.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/task_utils.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/presentation/widgets/comment_tile.dart';
import 'package:take_home_challenge_innoscripta/shared/presentation/widgets/app_loader.dart';
import 'package:take_home_challenge_innoscripta/shared/presentation/widgets/button_widget.dart';
import 'package:take_home_challenge_innoscripta/shared/presentation/widgets/text_field_widget.dart';

class TaskDetailBottomSheet extends StatefulWidget {
  final TaskModel task;
  final TasksBloc value;
  const TaskDetailBottomSheet({super.key, required this.task, required this.value,});

  @override
  State<TaskDetailBottomSheet> createState() => _TaskDetailBottomSheetState();
}

class _TaskDetailBottomSheetState extends State<TaskDetailBottomSheet> {
  final _commentController = TextEditingController();
  List<CommentModel> commentList = [];
  final ScrollController _scrollController = ScrollController();
  bool isTrackerOn = false;
  bool isCommentSectionLoading = true;
  int trackTime = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.value.add(TimerStoppedEvent());
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 15.h,
              top: 5.h, left: 15.w, right: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<TasksBloc, TasksState>(
                listener: (context, state) {
                  if(state is TaskTrackerStatus) {
                    isTrackerOn = state.isPlaying;
                    trackTime = state.time;
                  }
                  if(state is ChangedTaskTrackerStatus) {
                    isTrackerOn = state.isPlaying;
                    trackTime = state.time;
                  }
                  if(state is TimerRunInProgress) {
                    trackTime = state.duration;
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.w),
                              child: Text(
                                "[${TaskUtils.getTaskSectionFromSectionId(widget.task.sectionId!).toUpperCase()}]\n${widget.task.content ?? ""}",
                                style: AppTextStyle.xLargeBlack.copyWith(color: AppColors.taskDescription,
                                  fontWeight: FontWeight.bold,),
                              ),
                            ),
                          ),
                          if(widget.task.sectionId == doneSectionID)...[
                            IconButton(
                                padding: EdgeInsets.all(4.h),
                                iconSize: 40.h,
                                onPressed: (){
                                },
                                icon: const Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.green,)),
                          ]else...[
                            Column(
                              children: [
                                IconButton(
                                    padding: EdgeInsets.all(4.h),
                                    iconSize: 40.h,
                                    onPressed: (){
                                      context.read<TasksBloc>().add(ChangeTaskTrackerStatusEvent(taskId: widget.task.id!));
                                    },
                                    icon: Icon(isTrackerOn ? CupertinoIcons.pause_circle_fill : CupertinoIcons.play_circle_fill, color: AppColors.primaryColor,)),
                                if(trackTime == 0)
                                  Text(
                                    'Start Tracker',
                                    style: AppTextStyle.smallBlack.copyWith(color: AppColors.taskDescription,
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ]

                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom:10.h, top: 5.h),
                        child: const Divider(height: 1,),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _detailView('Created Date', DateFormat('dd MMM, yyyy, h:mm a').format(DateTime.parse(widget.task.createdAt!).toLocal())),
                          SizedBox(width: 30.w),
                          _detailView('Priority', TaskUtils.getPriorityNumberFromPriorityNumber(widget.task.priority!)),
                          SizedBox(width: 30.w),
                          if(trackTime != 0)
                            _detailView('Time Taken', TaskUtils.formatDuration(trackTime)),

                          /*if(trackTime != 0)
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.boardHeader,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
                                child: Text(
                                  TaskUtils.formatDuration(trackTime),
                                  style: AppTextStyle.xLargeWhite.copyWith(
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),*/
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _detailView('Description', widget.task.description ?? "-"),
                    ],
                  );
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical:5.h),
                child: const Divider(),
              ),
              Text(
                'Comments',
                style: AppTextStyle.mediumBlack.copyWith(color: AppColors.taskDescription,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h,),

              SizedBox(
                height: commentList.length > 3? 250.h : 200.h,
                child: BlocConsumer<TasksBloc, TasksState>(
                    listener: (context, state) {
                      if(state is CommentLoaded) {
                        isCommentSectionLoading = false;
                        commentList.clear();
                        commentList.addAll(state.comments);
                        _scrollToBottom();
                      }
                      if(state is CommentAdded) {
                        isCommentSectionLoading = false;
                        commentList.add(state.comment);
                        _commentController.clear();
                        _scrollToBottom();
                      }
                      if(state is CommentFailed) {
                        isCommentSectionLoading = false;
                      }
                    },
                    builder: (context, state) {
                      if (isCommentSectionLoading) {
                        return const AppLoader();
                      }
                      if(commentList.isEmpty){
                        return Column(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 32.h),
                                  Icon(
                                    CupertinoIcons.chat_bubble_text_fill,
                                    size: 55.h,
                                    color: AppColors.boardHeader,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'No comments yet',
                                    style: AppTextStyle.xLargeBlack.copyWith(color: AppColors.boardHeader,),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 8.h),

                        itemCount: commentList.length,
                        itemBuilder: (context, index) {
                          CommentModel comment = commentList[index];
                          return CommentItem(comment: comment);
                        },
                      );
                    },
                ),
              ),
              SizedBox(height: 15.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: _commentController,
                      hintText: 'Add Comment',
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  SizedBox(width: 10.w),

                  SizedBox(
                    width: 60.w,
                    child: BlocConsumer<TasksBloc, TasksState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is CommentAdding) {
                          return Align(
                            alignment: Alignment.center,
                              child: Container(
                                  width: 25.h,
                                  height: 25.h,
                                  margin: EdgeInsets.only(bottom: 8.h) ,
                                  child: const CircularProgressIndicator(color: AppColors.primaryColor,))
                          );
                        }
                        return ButtonWidget(
                          text: 'Send',
                          onPressed: () {
                            if(_commentController.text.trim().isNotEmpty){
                              FocusManager.instance.primaryFocus?.unfocus();

                              context.read<TasksBloc>().add(
                                AddCommentEvent(
                                  param: AddCommentParams(
                                      content: _commentController.text,
                                      taskId: widget.task.id!
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }

  Widget _detailView(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.mediumBlack.copyWith(color: AppColors.taskDescription,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 2.h,),
        Text(
          desc,
          style: AppTextStyle.largeBlack.copyWith(color: AppColors.taskDescription),
        ),
      ],
    );
  }

  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}