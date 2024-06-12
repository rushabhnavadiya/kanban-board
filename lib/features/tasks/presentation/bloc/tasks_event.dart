part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
}

class AddTaskEvent extends TasksEvent {
  const AddTaskEvent({required this.param});
  final AddTaskParams param;

  @override
  List<Object?> get props => [param];
}

class GetTasksEvent extends TasksEvent {
  const GetTasksEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTaskEvent extends TasksEvent {
  const UpdateTaskEvent({required this.param});
  final UpdateTaskParams param;

  @override
  List<Object?> get props => [param];
}
class UpdateStatusTaskEvent extends TasksEvent {
  const UpdateStatusTaskEvent({required this.param});
  final UpdateStatusTaskParams param;

  @override
  List<Object?> get props => [param];
}

class DeleteTaskEvent extends TasksEvent {
  const DeleteTaskEvent({required this.param});
  final String param;

  @override
  List<Object?> get props => [param];
}

class AddCommentEvent extends TasksEvent {
  const AddCommentEvent({required this.param});
  final AddCommentParams param;

  @override
  List<Object?> get props => [param];
}

class GetCommentsEvent extends TasksEvent {
  const GetCommentsEvent({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}

class ChangeTaskTrackerStatusEvent extends TasksEvent {
  const ChangeTaskTrackerStatusEvent({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}
class GetTaskTrackerStatusEvent extends TasksEvent {
  const GetTaskTrackerStatusEvent({required this.taskId});
  final String taskId;

  @override
  List<Object?> get props => [taskId];
}

class TimerTickedEvent extends TasksEvent {
  final int duration;

  const TimerTickedEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerStoppedEvent extends TasksEvent {

  @override
  List<Object?> get props => [];
}

