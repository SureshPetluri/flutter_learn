import 'package:get/get.dart';

import 'result_controller.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResultController());
  }
}
