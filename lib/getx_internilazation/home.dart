import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'repository.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text(
          'total_confirmed'.tr,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(Get.locale == const Locale('pt', 'BR')){
            Get.updateLocale(const Locale('en', 'US'));

            Repository.setLocal('en/US');
            print("Repository...${Repository.local()}");
          }else if(Get.locale == const Locale('en', 'US')){
            Get.updateLocale(const Locale('te', 'IN'));
            Repository.setLocal('te/IN');
            print("Repository...${Repository.local()}");
          }else{
            Get.updateLocale(const Locale('pt', 'BR'));
            Repository.setLocal('pt/BR');
            print("Repository...${Repository.local()}");
          }

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
