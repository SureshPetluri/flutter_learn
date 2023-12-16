import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_dropdown.dart';

class FarmerFormController extends GetxController {
  double fileSize = 0.0;
  Uint8List? aadhaarBytes;
  String aadhaar = "";
  Uint8List? panCardBytes;
  String panCard = "";

  Uint8List? bankBytes;
  String bank = "";

  Rx<Uint8List> imageBytes = Uint8List.fromList([]).obs;
  RxString image = "".obs;
  RxString countryCode = "".obs;
  RxString countryImage = "".obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pWDController = TextEditingController();
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

  RxList<DropdownItem<int>> vehicleList = <DropdownItem<int>>[].obs;
  bool isOpen = false;



  /*Future<void> pickImage(List<String> extensions, String capture) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null && result.files.isNotEmpty) {
      if (capture == 'bank') {
        bankBytes = result.files.single.bytes;
        bank = result.files.single.name;
        // knowing size of file code
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      } else if (capture == 'aadhaar') {
        aadhaarBytes = result.files.single.bytes;
        aadhaar = result.files.single.name;
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      } else if (capture == 'panCard') {
        panCardBytes = result.files.single.bytes;
        panCard = result.files.single.name;
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      } else {
        imageBytes.value = result.files.single.bytes;
        image = result.files.single.name;
        final Uint8List bytes = result.files.first.bytes!;
        final lengthKB = bytes.lengthInBytes / 1024;

        fileSize = lengthKB;
      }
      update();
      print("fileSize is $fileSize");
    }
  }*/

  List<DropdownItem<int>> listDropdown = [
    const DropdownItem(
      value: 0,
      child: Text("Nellore"),
    ),
    const DropdownItem(
      value: 0,
      child: Text("Chittore"),
    ),
  ];

  fetchCountryCode(String query) {
    List<CountryCode> countryCodes = [];
    countryCodes = allCountryCodes.value;

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
  void onReady() {
    vehicleList.value = listDropdown;

    print("FarmerForm OnReady Called");
    super.onReady();
  }
  @override
  void onInit() {

    fetchCountryCode("+91");
    super.onInit();
  }
}
