
import 'package:get/get.dart';

import 'farmer_form_controller.dart';

class FarmerFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FarmerFormController());
  }
}
