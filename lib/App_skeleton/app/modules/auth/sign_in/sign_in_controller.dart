import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isPWD = true.obs;

  submit(BuildContext context) async {
    print("srghwe");
    if (formKey.currentState?.validate() ?? false) {
      print("entered");
      Get.toNamed(AppRoutes.result);
    }
  }

  RxString appName = "".obs;
  RxString packageName = "".obs;
  RxString version = "".obs;
  RxString buildNumber = "".obs;

  packageInfor() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName.value = packageInfo.appName;
    packageName.value = packageInfo.packageName;
    version.value = packageInfo.version;
    buildNumber.value = packageInfo.buildNumber;
  }

  @override
  void onInit() {
    packageInfor();
    super.onInit();
  }
}
