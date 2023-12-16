import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/menu.dart';
import 'super_admin_controller.dart';

class SuperAdminScreen extends StatelessWidget {
  SuperAdminScreen({super.key});

  final SuperAdminController controller = SuperAdminController();

  @override
  Widget build(BuildContext context) {
    return MenuAppBar(
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(title: Text("login".tr)),
            ListTile(
                title: GestureDetector(
                    onTap: () {
                      controller.pickImage([
                        'jpg',
                        'jpeg',
                        'webp',
                        'png',
                      ], 'profile');
                    },
                    child: Text("upload profile Pic"))),
            ListTile(
                title: GestureDetector(
                    onTap: () {
                      controller.pickImage(
                        ['jpg', 'jpeg', 'webp', 'png'],
                        'panCard',
                      );
                    },
                    child: Text("upload pancard Pic"))),

            ListTile(
                title: GestureDetector(
                    onTap: () {
                      controller.pickImage(
                        ['jpg', 'jpeg', 'webp', 'png'],
                        'aadhaar',
                      );
                    },
                    child: const Text("upload Aadhar Pic"))),
          ],
        ),
        // sizedBoxH20(),
        // ElevatedButton(onPressed: () {
        //   if (Get.locale == const Locale('pt', 'BR')) {
        //     Get.updateLocale(const Locale('en', 'US'));
        //     AuthRepository.setLocalLang('en');
        //   } else if (Get.locale == const Locale('en', 'US')) {
        //     Get.updateLocale(const Locale('te', 'IN'));
        //     AuthRepository.setLocalLang('te');
        //   } else {
        //     Get.updateLocale(const Locale('pt', 'BR'));
        //     AuthRepository.setLocalLang('pt');
        //   }
        // }, child: Text("login".tr),)
      ),
    );
  }
}
