import 'package:get/get.dart';

import 'ip_controller.dart';

class IPBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(IPController());
  }
}
