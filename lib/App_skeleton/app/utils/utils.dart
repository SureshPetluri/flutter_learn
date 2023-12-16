import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    /// Location services are not enabled don't continue
    /// accessing the position and request users of the App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      /// Permissions are denied, next time you could try requesting permissions again
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    /// Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  /// When we reach here, permissions are granted and we can continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

void showCustomSnackBar(String? message, {bool isError = true}) {
  Get.showSnackbar(GetSnackBar(
    maxWidth: 500,
    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,
    duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(10.0),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}

/*
Future<void> pickImage(List<String> extensions,Rx<Uint8List> imageBytes,RxString image) async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: extensions,
  );

  if (result != null && result.files.isNotEmpty) {
    if (!kIsWeb) {
      File file = File(result.files.single.path!);
      imageBytes.value = await file.readAsBytes();
    } else {
      imageBytes.value = result.files.single.bytes ?? Uint8List.fromList([]);
    }

    print("imageBytes....${imageBytes}");
    image.value = result.files.single.name;
    print("image....${image.value}");
    // final Uint8List bytes = imageBytes.value;
    // final lengthKB = bytes.lengthInBytes / 1024;

    // fileSize = lengthKB;

    // print("fileSize is $fileSize");
  }
}
*/

Future<void> pickImageFromCameraOrGallery(
    BuildContext context, Rx<Uint8List> imageBytes, RxString image) async {
  if (!kIsWeb) {
    final picker = ImagePicker();
    String source = await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context, 'Camera'),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 40,
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context, 'Gallery'),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image,
                      size: 40,
                    ),
                    Text('Gallery'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    if (source != null) {
      XFile? pickedFile;
      if (source == 'Camera') {
        pickedFile = await picker.pickImage(
          source: ImageSource.camera,
        );
      } else if (source == 'Gallery') {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      }

      if (pickedFile != null) {
        imageBytes.value = await File(pickedFile.path).readAsBytes();
        image.value = pickedFile.name;
      }
    }
  } else {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'webp',
        'png',
      ],
    );

    if (result != null && result.files.isNotEmpty) {
      imageBytes.value = result.files.single.bytes ?? Uint8List.fromList([]);
      image.value = result.files.single.name ?? "";
    }
  }
}

Stack buildImageStack({
  required BuildContext context,
  double? height,
  double? width,
  required Rx<Uint8List> imageBytes,
  required RxString image,
}) {
  return Stack(
    children: [
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9.0),
          child: imageBytes.value.isNotEmpty
              ? Image.memory(
                  imageBytes.value,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
              : InkWell(
                  onTap: () {
                    pickImageFromCameraOrGallery(context, imageBytes, image);
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded),
                      Text("Upload Profile Picture",
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
        ),
      ),
      imageBytes.value.isNotEmpty
          ? Positioned(
              left: -1.0,
              bottom: -1.0,
              child: IconButton(
                color: Colors.blue,
                onPressed: () {
                  pickImageFromCameraOrGallery(context, imageBytes, image);
                },
                icon: const Icon(
                  Icons.mode_edit_outlined,
                  color: Colors.black,
                ),
              ),
            )
          : const SizedBox.shrink()
    ],
  );
}
