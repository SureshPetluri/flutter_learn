import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_internilazation/lang/en_US.dart';
import '../../../../getx_internilazation/lang/pt_BR.dart';
import '../../../../getx_internilazation/lang/te_IN.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'pt_BR': pt_BR,
        'te_IN': te_IN,
      };
}
