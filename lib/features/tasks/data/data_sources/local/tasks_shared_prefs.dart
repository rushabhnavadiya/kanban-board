import 'package:shared_preferences/shared_preferences.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/task_utils.dart';
import 'package:take_home_challenge_innoscripta/features/tasks/domain/models/track_time_model.dart';

class TasksSharedPrefs {
  final SharedPreferences _preferences;

  TasksSharedPrefs(this._preferences);

  static const String timerTasks = "timerTasks";

  /// __________ Clear Storage __________ ///
  Future<bool> clearAllLocalData() async {
    return true;
  }

  Future<void> playPauseTaskTracker(String taskId) async {
    List<TrackTimeModel> trackTimeModels = [];
    if(_preferences.getString(timerTasks) != null){
      trackTimeModels = TrackTimeModel.trackTimeModelsFromJson(_preferences.getString(timerTasks)!);
      int index = trackTimeModels.indexWhere((element) => element.taskId == taskId);
      if(index != -1){
        trackTimeModels[index].times.add(DateTime.now().toString());
      }else{
        trackTimeModels.add(TrackTimeModel(taskId:taskId, times: [DateTime.now().toString()]));
      }
    }else{
      trackTimeModels.add(TrackTimeModel(taskId:taskId,times: [DateTime.now().toString()]));
    }
    await _preferences.setString(timerTasks, TrackTimeModel.trackTimeModelsToJson(trackTimeModels));
  }

  int getTrackerTaskPassedSeconds(String taskId) {
    int duration = 0;
    if(_preferences.getString(timerTasks) != null){
      List<TrackTimeModel> trackTimeModels = TrackTimeModel.trackTimeModelsFromJson(_preferences.getString(timerTasks)!);
      int index = trackTimeModels.indexWhere((element) => element.taskId == taskId);
      if(index != -1){
        duration = TaskUtils.calculateTotalDurationInSeconds(trackTimeModels[index].times);
      }
    }
    return duration;
  }

  bool isTrackerOn(String taskId){
    bool isTrackOn = false;
    if(_preferences.getString(timerTasks) != null){
      List<TrackTimeModel> trackTimeModels = TrackTimeModel.trackTimeModelsFromJson(_preferences.getString(timerTasks)!);
      int index = trackTimeModels.indexWhere((element) => element.taskId == taskId);
      if(index != -1 && trackTimeModels[index].times.length % 2 != 0){
        isTrackOn = true;
      }
    }
    return isTrackOn;
  }
}