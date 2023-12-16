import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SuperAdminController extends GetxController {

  double fileSize = 0.0;
  Uint8List? _aadhaarBytes;
  String _aadhaar = "";
  Uint8List? _panCardBytes;
  String _panCard = "";
  Uint8List? _imageBytes;
  Uint8List? _bankBytes;
  String _bank = "";
  String _image = "";

  Future<void> pickImage(List<String> extensions, String capture) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null && result.files.isNotEmpty) {
      if (capture == 'bank') {
        _bankBytes = result.files.single.bytes;
        _bank = result.files.single.name;
        // knowing size of file code
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;

      } else if (capture == 'aadhaar') {
        _aadhaarBytes = result.files.single.bytes;
        _aadhaar = result.files.single.name;
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      } else if (capture == 'panCard') {
        _panCardBytes = result.files.single.bytes;
        _panCard = result.files.single.name;
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      } else {
        _imageBytes = result.files.single.bytes;
        _image = result.files.single.name;
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      }
      update();
      print("fileSize is $fileSize");
    }
  }
}
