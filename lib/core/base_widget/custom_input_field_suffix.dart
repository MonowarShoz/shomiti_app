import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imsomitiapp/core/theming/colors_manager.dart';





class CustomTextInputFieldSuffix extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final int? textLength;
  final bool isSecure;
  final String? Function(String?)? validatorFunction;
  final String? Function(String?)? onChanged;
  final VoidCallback? onComplete;
  final FocusNode? focusNode;
  final bool readOnly;
  final int? maxLine;
  final Widget? suffix;

  const CustomTextInputFieldSuffix(
      {super.key,
      this.isSecure = false,
      required this.controller,
      required this.textInputType,
      required this.hintText,
      this.validatorFunction,
      this.focusNode,
      this.onChanged,
      this.onComplete,
      this.readOnly = false,
      this.maxLine = 1,
      this.suffix,
      this.textLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      focusNode: focusNode,
      validator: validatorFunction,
      onChanged: onChanged,
      onEditingComplete: onComplete,

      //autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        LengthLimitingTextInputFormatter(textLength),
      ],
      style: TextStyle(
        fontSize: 15,
        fontFamily: "Kalpurush",
        color: Colors.black,
      ),
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLine,
      cursorColor: Colors.black12,
      obscureText: isSecure,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15),
        border: OutlineInputBorder(),
        hintText: hintText,
        suffix: suffix,
        hintStyle: TextStyle(
          color: ColorsManager.black,
          fontSize: 15,
        ),
        alignLabelWithHint: true,
      ),
    );
  }
}
