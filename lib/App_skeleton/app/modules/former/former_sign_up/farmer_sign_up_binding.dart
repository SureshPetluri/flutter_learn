import 'package:get/get.dart';
import 'farmer_sign_up_controller.dart';

class FarmerSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FarmerSignUpController());
  }
}
