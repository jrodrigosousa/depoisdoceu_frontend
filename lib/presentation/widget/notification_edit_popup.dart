import 'package:flutter/material.dart';

class TimeDecompositionPopup{
  final int totalMinutes;

  TimeDecompositionPopup({Key? key, this.totalMinutes = 0});


  static Future<int?> showTimeDecompositionDialog(BuildContext context, int minutes) async {
    int days = minutes ~/ (60 * 24);
    int hours = (minutes % (60 * 24)) ~/ 60;
    int remainingMinutes = minutes % 60;

    TextEditingController dayController = TextEditingController(text: days.toString());
    TextEditingController hourController = TextEditingController(text: hours.toString());
    TextEditingController minuteController = TextEditingController(text: remainingMinutes.toString());

    return showDialog<int?>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Edit Time'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dayController,
                decoration: InputDecoration(labelText: 'Days'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: hourController,
                decoration: InputDecoration(labelText: 'Hours'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: minuteController,
                decoration: InputDecoration(labelText: 'Minutes'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                int newDays = int.tryParse(dayController.text) ?? 0;
                int newHours = int.tryParse(hourController.text) ?? 0;
                int newMinutes = int.tryParse(minuteController.text) ?? 0;

                // Convert the time back to total minutes
                int totalNewMinutes = newDays * 24 * 60 + newHours * 60 + newMinutes;

                // You can now return this value or use it as needed
                Navigator.of(dialogContext).pop(totalNewMinutes);
              },
            ),
          ],
        );
      },
    );
  }
}