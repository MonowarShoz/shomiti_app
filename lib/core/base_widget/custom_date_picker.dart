import 'package:flutter/material.dart';
Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0EA5E9), // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Color(0xFF374151), // body text color
          ),
        ),
        child: child!,
      );
    },
  );

  return pickedDate; // can be null if user cancels
}