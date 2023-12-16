import 'package:get/get.dart';

import '../modules/auth/sign_in/sign_in_binding.dart';
import '../modules/auth/sign_in/sign_in_screen.dart';
import '../modules/former/former_form/farmer_form_binding.dart';
import '../modules/former/former_form/farmer_form_screen.dart';
import '../modules/former/former_sign_up/farmer_sign_up_binding.dart';
import '../modules/former/former_sign_up/farmer_sign_up_screen.dart';
import '../modules/issues_posting/ip_binding.dart';
import '../modules/issues_posting/ip_screen.dart';
import '../modules/qr_code_scanner/scanner_binding.dart';
import '../modules/qr_code_scanner/scanner_screen.dart';
import '../modules/qr_result/result_binding.dart';
import '../modules/qr_result/result_screen.dart';
import '../modules/super_admin/super_admin_binding.dart';
import '../modules/super_admin/super_admin_screen.dart';
import 'app_pages.dart';

class AppPages {
  static getPageWithTransition({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    bool boolAuthorized = true,
  }) =>
      GetPage(
        name: name,
        page: page,
        binding: binding,
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
      );
  static final List<GetPage> pages = [
    /// SignInPage
    getPageWithTransition(
      name: AppRoutes.farmerSignUp,
      page: () => FarmerSignUpScreen(),
      binding: FarmerSignUpBinding(),
    ),

    /// SignUpPage
    getPageWithTransition(
      name: AppRoutes.signIn,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),

    /// FarmerFormFillUpPage
    getPageWithTransition(
      name: AppRoutes.farmerForm,
      page: () => FarmerFormScreen(),
      binding: FarmerFormBinding(),
    ),
    /// SuperAdminPage
    getPageWithTransition(
      name: AppRoutes.superAdmin,
      page: () => SuperAdminScreen(),
      binding: SuperAdminBinding(),
    ),

    /// SuperAdminPage
    getPageWithTransition(
      name: AppRoutes.iPScreen,
      page: () => IPScreen(),
      binding: IPBinding(),
    ),
    /// ScannerPage
    getPageWithTransition(
      name: AppRoutes.scanner,
      page: () => ScannerScreen(),
      binding: ScannerBinding(),
    ),/// ScannerPage
    getPageWithTransition(
      name: AppRoutes.result,
      page: () => ResultScreen(),
      binding: ResultBinding(),
    ),
  ];
}
