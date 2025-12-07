import 'dart:convert';

import 'package:file_picker/file_picker.dart';
class FilePickerHelper{
static Future<String?> pickDocumentBase64() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result == null || result.files.isEmpty) return null;

      final fileBytes = result.files.first.bytes;
      if (fileBytes == null) return null;

      final documentBase64 = base64Encode(fileBytes);
      return documentBase64;
    } catch (e) {
      print("Document pick error: $e");
      return null;
    }
  }
}