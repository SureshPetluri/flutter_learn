import 'dart:ui';

import 'package:get_storage/get_storage.dart';

class Repository {
  static final GetStorage _storage = GetStorage("local_storage");

  static String? local() => _storage.read('locale');
  static  setLocal(String val) => _storage.write('locale',val);

  // static changeTheme(bool val) => _storage.write('themeMode', val);
}
