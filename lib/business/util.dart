import 'package:flutter/material.dart';

dynamic getValueOrNUll(dynamic Function() expression) {
  try {
    return expression();
  } catch (_) {
    return null;
  }
}


TimeOfDay? tryParseTime(String? time) {
  if (time == null) return null;

  var timeParts = time.split(':');
  if (timeParts.length != 2) return null;
  if (timeParts[0].length != 2) return null;
  if (timeParts[1].length != 2) return null;

  int? hour = int.tryParse(timeParts[0]);
  int? minute = int.tryParse(timeParts[1]);

  if (hour == null || minute == null) return null;
  if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

  return TimeOfDay(hour: hour, minute: minute);
}

