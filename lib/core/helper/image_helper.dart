import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'dart:isolate';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String),fit: BoxFit.cover,gaplessPlayback: true,);
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String imgBytTobase64String(Uint8List data) {
  return base64Encode(data);
}

String convertStringToBase64(String data) {
  // String EncodedJson = jsonEncode(data);
  var jsonEncodedByte = utf8.encode(data);
  return base64Encode(jsonEncodedByte);
}

 String getFileSizeString({required int bytes, int decimals = 0}) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
}

String convertToBase(List<int> byte) {
  return base64Encode(byte);
}




Future<String> convertByteImageToBase64(Uint8List byteImage) async {
  ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(_isolateFunction, receivePort.sendPort);
  SendPort sendPort = await receivePort.first;

  Completer<String> completer = Completer<String>();

  sendPort.send({
    'byteImage': byteImage,
    'completer': completer,
  });

  return completer.future;
}

void _isolateFunction(SendPort sendPort) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((dynamic data) {
    List<int> byteImage = data['byteImage'];
    Completer<String> completer = data['completer'];

    String base64Image = base64Encode(byteImage);
    completer.complete(base64Image);
  });
}

Future<String> compressImgInBg(Uint8List byteImage) async {
  try {
    Uint8List compressedImage = await FlutterImageCompress.compressWithList(
      byteImage,
      minHeight: 800,
      minWidth: 600,
      quality: 40,
      rotate: 0
    );

    String base64Image = base64Encode(compressedImage);
    return base64Image;
  } catch (e) {
    throw Exception('Compression failed: $e');
  }
}