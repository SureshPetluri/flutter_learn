import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class IPController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<Uint8List> imageBytes = Uint8List.fromList([]).obs;
  RxString image = "".obs;
  double fileSize = 0.0;


  submit(){
    if(formKey.currentState?.validate() ?? false){

    }
  }
}
