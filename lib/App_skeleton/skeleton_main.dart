import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/repository/auth_repository.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/themes/colors.dart';
import 'app/utils/constants.dart';
import 'app/utils/firebase_notifications.dart';
import 'app/utils/lang/translation_service.dart';

Future<RemoteMessage> _backgroundMessageHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  return message;
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(await _backgroundMessageHandler);
    setupInteractedMessage();
  }
  await GetStorage.init(Auth_Repo);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Crop',
      translations: TranslationService(),
      locale: Locale(AuthRepository.localLang() ??
          Get.deviceLocale.toString().split("_")[0]),
      theme: buildTheme(context),
      initialRoute: AppRoutes.signIn,
      getPages: AppPages.pages,
      // home:  AppStepper(),
      // home: CustomDataTable(
      //   headers: ["S.No","name", "age", "roll", "roll", "roll", "roll"],
      //   myData: [
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     },
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     },
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     },
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     },
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     },
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     },
      //     {
      //       "age": 13,
      //       "name": "Suresh",
      //       "roll": "Doctor",
      //       "rolls": "rolls",
      //       "rollss": "oiuoi",
      //       "rollsss": ".,m,m,"
      //     }
      //   ],
      // ),
    );
  }

  ThemeData buildTheme(BuildContext context) {
    var themeData = Theme.of(context);
    return themeData.copyWith(
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      textTheme: themeData.textTheme.apply(fontFamily: "Lato"),
      appBarTheme: buildAppBarTheme(themeData),
      scaffoldBackgroundColor: CustomColorTheme.primary,
      inputDecorationTheme: buildInputDecorationTheme(themeData),
      checkboxTheme: themeData.checkboxTheme.copyWith(
          fillColor: MaterialStateColor.resolveWith(
              (_) => CustomColorTheme.buttonFill)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => CustomColorTheme.gradientLoginPageStart)),
      ),
      colorScheme: const ColorScheme.light()
          .copyWith(primary: CustomColorTheme.inputHint),
    );
  }

  AppBarTheme buildAppBarTheme(ThemeData themeData) {
    return themeData.appBarTheme.copyWith(
      titleSpacing: 5.0,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      color: CustomColorTheme.primary,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
          fontFamily: "Lato"),
      toolbarTextStyle: const TextStyle(color: Colors.black),
    );
  }

  InputDecorationTheme buildInputDecorationTheme(ThemeData themeData) {
    return themeData.inputDecorationTheme.copyWith(
      // filled: true,
      // fillColor: CustomColorTheme.inputFill,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green, // Color of the bottom line
          width: 2.0, // Width of the bottom line
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, // Color of the bottom line
          width: 2.0, // Width of the bottom line
        ),
      ),

      border: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue, // Color of the bottom line
          width: 2.0, // Width of the bottom line
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent, // Color of the bottom line
          width: 2.0, // Width of the bottom line
        ),
      ),
      // hintStyle: AppTextTheme.robotoHintTextStyle,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
    );
  }
}
