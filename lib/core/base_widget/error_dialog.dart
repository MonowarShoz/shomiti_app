
import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/core/theming/colors_manager.dart';
import 'package:imsomitiapp/core/theming/text_styles.dart';
import 'package:imsomitiapp/core/utils/app_strings.dart';



class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.white,
      content: Text(message, style: TextStyles.font14DarckBlueMedium),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(AppStrings.ok),
        ),
      ],
    );
  }

  static void show(BuildContext context, String message) {
    showDialog(context: context, builder: (_) => ErrorDialog(message: message));
  }
}
