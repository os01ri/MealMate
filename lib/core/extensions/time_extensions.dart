import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isEqual(TimeOfDay timeOfDay) {
    return (hour == timeOfDay.hour) && (minute == timeOfDay.minute);
  }
}

extension TimeExtension on String {
  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    } else if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    } else if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    } else if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }

    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }

    return "just now";
  }

  String getTimeToLocalZone() {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime time = DateTime.tryParse('$date $this Z') ?? DateTime.parse(this);
    time = time.toLocal();
    return DateFormat.jm().format(time).padLeft(8, '0');
  }

  String getTimeToUtc() {
    String date = DateFormat('yyyy-mm-dd').format(DateTime.now());
    DateTime time = DateTime.parse('$date $this');
    if (time.timeZoneName != 'UTC') {
      time = time.toUtc();
    }
    return DateFormat.Hms().format(time);
  }
}
