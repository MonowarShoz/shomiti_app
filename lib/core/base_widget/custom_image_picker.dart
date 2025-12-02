import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();
  static Future<File?> pickImageFile() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 30,
      );

      if (pickedFile == null) return null;
      return File(pickedFile.path);
    } catch (e) {
      print("Image pick error: $e");
      return null;
    }
  }

 static Future<String?> pickImgbase64() async {
    XFile? pickedFile;
    try {
      pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 23,
        maxHeight: 600,
        maxWidth: 800,
      );
      if (pickedFile == null) return null;

      final byteFile = File(pickedFile.path);
      final imgbyte = byteFile.readAsBytesSync();
      //debugPrint('gallery Image size ${imgbyte.length} byte');
      //final compressedByte = await Utils().compressImg(imgbyte);

      final schoolLogoBase64 = base64Encode(imgbyte);
      return schoolLogoBase64;
    } catch (e) {
      return null;
    }
  }
}
