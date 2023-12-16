import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/*
Future<void> pickImageFromCameraOrGallery(BuildContext context,List<String> extensions, Rx<Uint8List> imageBytes, RxString image) async {
  final picker = ImagePicker();
  String source = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image Source'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Camera'),
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'Gallery'),
            child: Text('Gallery'),
          ),
        ],
      );
    },
  );

  if (source != null) {
    if (source == 'Camera') {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        imageBytes.value = await file.readAsBytes();
        image.value = pickedFile.name;
      }
    } else if (source == 'Gallery') {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        imageBytes.value = await file.readAsBytes();
        image.value = pickedFile.name;
      }
    }
  }
}
*/

/*
Future<void> pickImageWithFallback(BuildContext context,List<String> extensions, Rx<Uint8List> imageBytes, RxString image) async {
  final picker = ImagePicker();
  List<XFile> cameras = await availableCameras();

  if (cameras.isEmpty) {
    await pickImageFromGallery(extensions, imageBytes, image);
  } else {
    String source = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          actions: <Widget>[
            if (cameras?.isNotEmpty ?? false)
              TextButton(
                onPressed: () => Navigator.pop(context, 'Camera'),
                child: Text('Camera'),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Gallery'),
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );

    if (source == 'Camera') {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        File file = File(pickedFile.path);
        imageBytes.value = await file.readAsBytes();
        image.value = pickedFile.name;
      }
    } else if (source == 'Gallery') {
      await pickImageFromGallery(extensions, imageBytes, image);
    }
  }
}

Future<void> pickImageFromGallery(List<String> extensions, Rx<Uint8List> imageBytes, RxString image) async {
  final picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    File file = File(pickedFile.path);
    imageBytes.value = await file.readAsBytes();
    image.value = pickedFile.name;
  }
}
*/
