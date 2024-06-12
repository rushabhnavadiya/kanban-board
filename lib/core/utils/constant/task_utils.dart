import 'package:flutter/material.dart';
import 'package:take_home_challenge_innoscripta/core/utils/constant/app_constants.dart';

class TaskUtils{
  static final List<String> taskPriorities = [
    'High',
    'Medium',
    'Low',
    'None',
  ];


  static String getTaskSectionFromSectionId(String sectionID) {
    switch (sectionID) {
      case todoSectionID:
        return 'Todo';
      case inProgressSectionID:
        return 'InProgress';
      case doneSectionID:
        return 'Done';
      default:
        return 'Todo';
    }
  }
  static int getPriorityNumberFromPriorityName(String priority) {
    switch (priority) {
      case 'None':
        return 1;
      case 'Low':
        return 2;
      case 'Medium':
        return 3;
      case 'High':
        return 4;
      default:
        return 1;
    }
  }
  static String getPriorityNumberFromPriorityNumber(int priority) {
    switch (priority) {
      case 1:
        return 'None';
      case 2:
        return 'Low';
      case 3:
        return 'Medium';
      case 4:
        return 'High';
      default:
        return 'None';
    }
  }
  static Color getColorFromPriorityName(String priority) {
    switch (priority) {
      case 'None':
        return Colors.grey;
      case 'Low':
        return Colors.yellow;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  static Color getColorFromPriority(int? priority) {
    switch (priority ?? 1) {
      case 1:
        return Colors.grey;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }


  static Color getRandomColor(int index) {
    // final Random random = Random();
    List<Color> colors = [
      const Color(0xFF00a3bf),
      const Color(0xFFde350a),
      const Color(0xFF008759),
      const Color(0xFFff345c),
      const Color(0xFFff9900),
      const Color(0xFF055593),
      const Color(0xFFb11f0e),
      const Color(0xFF1a659e),
      const Color(0xFF414659),
      const Color(0xFFdc3913),
    ];

    // return colors[random.nextInt(colors.length)];
    return colors[index];
  }
  static int calculateTotalDurationInSeconds(List<String> timeStrings) {
    if (timeStrings.isEmpty) return 0;

    final List<DateTime> times = timeStrings.map((timeString) {
      return DateTime.parse(timeString);
    }).toList();

    Duration totalDuration = Duration.zero;

    // Calculate the duration between each pair of consecutive timestamps
    for (int i = 0; i < times.length - 1; i += 2) {
      totalDuration += times[i + 1].difference(times[i]);
    }

    // If the list has an odd number of timestamps, calculate the duration between the last timestamp and the current time
    if (times.length % 2 != 0) {
      totalDuration += DateTime.now().difference(times.last);
    }

    // Return the total duration in seconds
    return totalDuration.inSeconds;
  }
  static String formatDuration(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String formattedTime = "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
    return formattedTime;
  }
}
