import 'package:flutter/material.dart';

class FormWidgets {
  /// Label text used above form fields
  static Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  /// Common InputDecoration
  static InputDecoration decoration({String? errorText}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(16),
      errorText: errorText,
    );
  }

  /// Dropdown loading state
  static Widget dropdownLoadingWidget({
    required String loadingTitle,
  }) {
    return DropdownButtonFormField<int>(
      decoration: decoration(),
      items: const [],
      onChanged: null,
      hint: Row(
        children: const [
          SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 12),
          Text("Loading..."),
        ],
      ),
    );
  }

  static Widget dropdownErrorWidget({required String errorTitle, required VoidCallback callback}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<int>(
          value: null,
          decoration: decoration(errorText: errorTitle),
          items: const [],
          onChanged: null,
          hint: const Text('Unable to load'),
        ),
        const SizedBox(height: 8),
        TextButton.icon(onPressed: callback, icon: const Icon(Icons.refresh), label: const Text('Retry')),
      ],
    );
  }
  static Widget filledDropdownWidget({required String fieldValue,}) {

      return  DropdownButtonFormField<String>(
          initialValue: fieldValue,
          decoration: decoration(errorText: null),
          items: const [],
          onChanged: null,
          hint: const Text('Unable to load'),
        );


  }
}