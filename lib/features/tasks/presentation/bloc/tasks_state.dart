part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TasksState {
  const TaskInitial();

  @override
  List<Object> get props => [];
}

class TaskLoading extends TasksState {
  const TaskLoading();

  @override
  List<Object> get props => [];
}

class TaskLoaded extends TasksState {
  final List<TaskModel> tasks;
  const TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskEventFailed extends TasksState {
  final Failure failure;

  const TaskEventFailed(this.failure);

  @override
  List<Object> get props => [failure];
}

class TaskAdded extends TasksState {
  final List<TaskModel> tasks;
  const TaskAdded(this.tasks);

  @override
  List<Object> get props => [tasks];
}
class TaskUpdated extends TasksState {
  final List<TaskModel> tasks;
  const TaskUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class CommentLoading extends TasksState {
  const CommentLoading();

  @override
  List<Object> get props => [];
}
class CommentLoaded extends TasksState {
  final List<CommentModel> comments;
  const CommentLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}
class CommentFailed extends TasksState {
  final Failure failure;

  const CommentFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
class CommentAdded extends TasksState {
  final CommentModel comment;
  const CommentAdded(this.comment);

  @override
  List<Object> get props => [comment];
}
class CommentAdding extends TasksState {
  const CommentAdding();

  @override
  List<Object> get props => [];
}

class ChangedTaskTrackerStatus extends TasksState {
  final bool isPlaying;
  final int time;

  const ChangedTaskTrackerStatus(this.isPlaying, this.time);

  @override
  List<Object> get props => [isPlaying, time];
}
class TaskTrackerStatus extends TasksState {
  final bool isPlaying;
  final int time;
  const TaskTrackerStatus(this.isPlaying, this.time);

  @override
  List<Object> get props => [isPlaying, time];
}

class TimerRunInProgress extends TasksState {
  final int duration;

  const TimerRunInProgress(this.duration);

  @override
  List<Object> get props => [duration];
}


