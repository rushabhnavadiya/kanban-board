import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_home_challenge_innoscripta/core/network/error/failures.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/data/data_sources/local/tasks_shared_prefs.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_comment_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/add_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/comment_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/task_model.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_status_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/update_task_params.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/add_new_comment_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/add_new_task_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/get_comments_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/update_status_task_use_case.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/usecases/update_task_use_case.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {

  List<TaskModel> taskList = [];
  Timer? _timer;

  TasksBloc(
      this._addNewTaskUseCase,
      this._getTasksUseCase,
      this._updateTaskUseCase,
      this._updateStatusTaskUseCase,
      this._deleteTaskUseCase,
      this._addNewCommentUseCase,
      this._getCommentsUseCase,
      ) : super(const TaskInitial()) {
    on<AddTaskEvent>(_onAddTaskEvent);
    on<GetTasksEvent>(_onGetTasksEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<UpdateStatusTaskEvent>(_onUpdateStatusTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
    on<AddCommentEvent>(_onAddNewCommentEvent);
    on<GetCommentsEvent>(_onGetCommentsEvent);
    on<ChangeTaskTrackerStatusEvent>(_onChangeTaskTrackerStatusEvent);
    on<GetTaskTrackerStatusEvent>(_onGetTaskTrackerStatusEvent);
    on<TimerStoppedEvent>(_onTimerStoppedEvent);
    on<TimerTickedEvent>(_onTimerTickedEvent);
  }

  final AddNewTaskUseCase _addNewTaskUseCase;
  final GetTasksUseCase _getTasksUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final UpdateStatusTaskUseCase _updateStatusTaskUseCase;
  final AddNewCommentUseCase _addNewCommentUseCase;
  final GetCommentsUseCase _getCommentsUseCase;

  Future<FutureOr<void>> _onAddTaskEvent(
      AddTaskEvent event,
      Emitter<TasksState> emit,
      ) async {

    await _addNewTaskUseCase(event.param).then(
          (value) => value.fold(
            (failure) => emit(TaskEventFailed(failure)),
            (task) {
              taskList.insert(0, task);
              emit(TaskAdded(taskList));
            }),
    );
  }

  Future<FutureOr<void>> _onGetTasksEvent(
      GetTasksEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const TaskLoading());
    await _getTasksUseCase(event).then((value) {
      value.fold(
          (failure) {
            emit(TaskEventFailed(failure));
            },
          (tasks) {
            taskList = tasks;
            emit(TaskLoaded(tasks));
          });
    });
  }

  Future<FutureOr<void>> _onGetCommentsEvent(
      GetCommentsEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const CommentLoading());
    await _getCommentsUseCase(event.taskId).then((value) {
      value.fold(
          (failure) {
            emit(CommentFailed(failure));
            },
          (comments) {
            emit(CommentLoaded(comments));
          });
    });
  }

  Future<FutureOr<void>> _onAddNewCommentEvent(
      AddCommentEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const CommentAdding());

    await _addNewCommentUseCase(event.param).then(
          (value) => value.fold(
              (failure) => emit(CommentFailed(failure)),
              (comment) {
            emit(CommentAdded(comment));
          }),
    );
  }
  Future<FutureOr<void>> _onChangeTaskTrackerStatusEvent(
      ChangeTaskTrackerStatusEvent event,
      Emitter<TasksState> emit,
      ) async {
    TasksSharedPrefs sharedPrefs = TasksSharedPrefs(await SharedPreferences.getInstance());
    await sharedPrefs.playPauseTaskTracker(event.taskId);
    bool isTrackerPlaying = sharedPrefs.isTrackerOn(event.taskId);

    if(isTrackerPlaying){
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(TimerTickedEvent(sharedPrefs.getTrackerTaskPassedSeconds(event.taskId)));
      });
    }else{
      _timer?.cancel();
    }

    emit(ChangedTaskTrackerStatus(isTrackerPlaying, sharedPrefs.getTrackerTaskPassedSeconds(event.taskId)));
  }
  Future<FutureOr<void>> _onTimerStoppedEvent(
      TimerStoppedEvent event,
      Emitter<TasksState> emit,
      ) async {
    _timer?.cancel();
  }
  FutureOr<void> _onTimerTickedEvent(
      TimerTickedEvent event,
      Emitter<TasksState> emit) {
    emit(TimerRunInProgress(event.duration));
  }

  Future<FutureOr<void>> _onGetTaskTrackerStatusEvent(
      GetTaskTrackerStatusEvent event,
      Emitter<TasksState> emit,
      ) async {
    TasksSharedPrefs sharedPrefs = TasksSharedPrefs(await SharedPreferences.getInstance());

    bool isPlaying = sharedPrefs.isTrackerOn(event.taskId);
    int duration = sharedPrefs.getTrackerTaskPassedSeconds(event.taskId);

    if(isPlaying){
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(TimerTickedEvent(sharedPrefs.getTrackerTaskPassedSeconds(event.taskId)));
      });
    }else{
      _timer?.cancel();
    }

    emit(TaskTrackerStatus(isPlaying, duration));
  }


  Future<FutureOr<void>> _onUpdateStatusTaskEvent(
      UpdateStatusTaskEvent event,
      Emitter<TasksState> emit,
      ) async {
    emit(const TaskLoading());
    int index = taskList.indexWhere((element) => element.id == event.param.taskId);
    if(index != -1){
      TasksSharedPrefs sharedPrefs = TasksSharedPrefs(await SharedPreferences.getInstance());
      bool isTrackerPlaying = sharedPrefs.isTrackerOn(event.param.taskId!);
      if(isTrackerPlaying){
        await sharedPrefs.playPauseTaskTracker(event.param.taskId!);
      }
      taskList[index].sectionId = event.param.sectionId;
      emit(TaskUpdated(taskList));
    }

    await _updateStatusTaskUseCase(event.param).then(
          (value) => value.fold(
              (failure){
            // emit(TaskEventFailed(tasks: state.tasks),);
          },
              (task) {
            // emit(TaskLoaded(tasks: state.tasks..add(task)),);
          }),
    );

  }

  FutureOr<void> _onUpdateTaskEvent(
      UpdateTaskEvent event,
      Emitter<TasksState> emit,
      ) {
    // emit(TaskLoading());
    // _updateTaskUseCase(event.param).then(
    //       (value) => value.fold(
    //         (failure) => emit(
    //       TaskEventFailed(tasks: state.tasks),
    //     ),
    //         (task) => emit(
    //       TaskLoaded(tasks: state.tasks..add(task)),
    //     ),
    //   ),
    // );
  }

  FutureOr<void> _onDeleteTaskEvent(
      DeleteTaskEvent event,
      Emitter<TasksState> emit,
      ) {
    // emit(TaskLoading());
    // _deleteTaskUseCase(event.param).then(
    //       (value) => value.fold(
    //         (failure) => emit(
    //       TaskEventFailed(tasks: state.tasks),
    //     ),
    //         (task) => emit(
    //       TaskLoaded(tasks: state.tasks),
    //     ),
    //   ),
    // );
  }

}