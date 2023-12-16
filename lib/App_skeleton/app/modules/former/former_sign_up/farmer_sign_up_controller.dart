import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class FarmerSignUpController extends GetxController {
  double fileSize = 0.0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<Uint8List> imageBytes = Uint8List.fromList([]).obs;
  RxString image = "".obs;
  RxString countryCode = "".obs;
  RxString countryImage = "".obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Rx<TextEditingController> pWDController = TextEditingController().obs;
  TextEditingController cPWDController = TextEditingController();
  TextEditingController countrySearchController = TextEditingController();
  RxBool isPWD = true.obs;

  RxList<CountryCode> allCountryCodes = codes
      .map((Map<String, String> country) {
        return CountryCode(
          name: country['name']!,
          code: country['code']!,
          dialCode: country['dial_code']!,
          flagUri: 'flags/${country['code']!.toLowerCase()}.png',
        );
      })
      .toList()
      .obs;

  /*Future<void> pickImage(List<String> extensions,) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null && result.files.isNotEmpty) {
      if (!kIsWeb) {
        File file = File(result.files.single.path!);
        imageBytes.value = await file.readAsBytes();
      } else {
        imageBytes.value = result.files.single.bytes ?? Uint8List.fromList([]);
      }

      print("imageBytes....${imageBytes}");
      image.value = result.files.single.name;
      print("image....${image.value}");
      final Uint8List bytes = imageBytes.value;
      final lengthKB = bytes.lengthInBytes / 1024;

      fileSize = lengthKB;

      print("fileSize is $fileSize");
    }
  }*/

  submitSignUp(BuildContext context) {
    // if (formKey.currentState?.validate() ?? false) {
    // pickImageFromCameraOrGallery(
    //     context,
    //     imageBytes,
    //     image);
    Get.toNamed(AppRoutes.farmerForm);
    // }
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();

    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }

  fetchCountryCode(String query) {
    List<CountryCode> countryCodes = [];

    countryCodes = allCountryCodes.value
        .where((user) =>
            (user.name != null &&
                user.name!.toLowerCase().contains(query.toLowerCase())) ||
            (user.dialCode != null &&
                user.dialCode!.toLowerCase().contains(query.toLowerCase())) ||
            (user.code != null &&
                user.code!.toLowerCase().contains(query.toLowerCase())))
        .toList();
    countryCode.value = countryCodes[0].dialCode ?? "";
    countryImage.value = countryCodes[0].flagUri ?? "";
  }

  @override
  void onInit() {
    fetchCountryCode("+91");
    getCurrentLocation();
    super.onInit();
  }
}
