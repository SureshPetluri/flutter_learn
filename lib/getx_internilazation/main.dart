import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'home.dart';
import 'lang/translation_service.dart';
import 'repository.dart';

main() async {
  await GetStorage.init("local_storage");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale localeVal = const Locale('en', 'US');

  func() {
    switch (localeVal.languageCode) {
      case 'en':
        print('English');
        break;
      case 'te':
        print('Telugu');
        break;
      case 'pt':
        print('Portuguese');
        break;
      default:
        print('Unknown language');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Internationalization',
      translations: TranslationService(),
      locale: Locale(Repository.local()?.split("/")[0] ?? "en",
          Repository.local()?.split("/")[1] ?? "US"),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHome(),
    );
  }
}
