import 'package:get_storage/get_storage.dart';

import '../../utils/constants.dart';

class AuthRepository {
  static final GetStorage _appStorage = GetStorage(Auth_Repo);


  static setAuthToken(String password) => _appStorage.write("authToken", password);

  static String getAuthToken() => _appStorage.read("authToken") ?? "";

  static String? localLang() => _appStorage.read('locale');
  static  setLocalLang(String val) => _appStorage.write('locale',val);
}
