import 'package:flutter/material.dart';
import 'package:imsomitiapp/core/base_widget/spacing.dart';
import 'package:imsomitiapp/core/helper/extensions.dart';
import 'package:imsomitiapp/core/theming/app_dimensions.dart';
import 'package:imsomitiapp/core/theming/colors_manager.dart';
import 'package:imsomitiapp/core/theming/text_styles.dart';



class AppCustomDialog extends StatefulWidget {
  final String? title;
  final IconData? iconData;
  final String message;
  final String okActionText;
  final String cancelActionText;
  final Future<void> Function() okAction;
  final VoidCallback? cancelAction;

  const AppCustomDialog({
    super.key,
    this.title,
    this.iconData,
    required this.message,
    required this.okActionText,
    required this.cancelActionText,
    required this.okAction,
    this.cancelAction,
  });

    static Future<void> show({
    required BuildContext context,
    String? title,
    IconData? icon,
    required String message,
    required Future<void> Function() okAction,
    required String okActionText,
    VoidCallback? cancelAction,
    String? cancelText,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (_) => AppCustomDialog(
            title: title,
            iconData: icon,
            message: message,
            okAction: okAction,
            okActionText: okActionText,
            cancelAction: cancelAction,
             cancelActionText: '',
          ),
    );
  }

  @override
  State<AppCustomDialog> createState() => _AppCustomDialogState();
}

class _AppCustomDialogState extends State<AppCustomDialog> {
   bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsManager.white,
      title:
          widget.title != null && widget.title!.isNotEmpty
              ? Center(
                child: Text(
                  widget.title!,
                  style: TextStyles.font15BlueSemiBold,
                ),
              )
              : null,
      content: Padding(
        padding: EdgeInsets.fromLTRB(
          AppDimensions.padding_5,
          AppDimensions.verticalPadding_10,
          AppDimensions.padding_5,
          0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.iconData != null) Icon(widget.iconData),
            if (widget.iconData != null) verticalSpace(AppDimensions.height_14),
            Text(widget.message, style: TextStyles.font14BlackRegular),
          ],
        ),
      ),
      actions: [
        if (widget.cancelActionText != null && widget.cancelAction != null)
          TextButton(
            onPressed:
                _isLoading
                    ? null
                    : () {
                      Navigator.of(context).pop();
                      widget.cancelAction!();
                    },
            child: Text(
              widget.cancelActionText!,
              style: TextStyles.font14UnderlineDarckBlueMedium,
            ),
          ),
        ElevatedButton(
          onPressed:
              _isLoading
                  ? null
                  : () async {
                    setState(() => _isLoading = true);
                    try {
                      await widget.okAction();
                      if (context.mounted){
                        context.pop();
                      }
                      
                    } catch (e) {
                       if (context.mounted){
                        context.pop();
                      }
                    } finally {
                      if (mounted) setState(() => _isLoading = false);
                    }
                  },
          child:
              _isLoading
                  ? SizedBox(
                    width: AppDimensions.width_20,
                    height: AppDimensions.height_20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : Text(
                    widget.okActionText,
                    style: TextStyles.font14DarckBlueMedium,
                  ),
        ),
      ],
    );
  }
}
