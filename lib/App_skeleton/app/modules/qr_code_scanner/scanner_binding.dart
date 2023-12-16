import 'package:get/get.dart';

import 'scanner_controller.dart';

class ScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScannerController());
  }
}
