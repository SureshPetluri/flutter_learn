import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_textform_field.dart';

void showCountryCodePicker(
    {required BuildContext context,
    required List<CountryCode> allCountryCodes,
    required TextEditingController countrySearchController,
    required RxString countryImage,
    required RxString countryCode}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.zero,
              child: Container(
                height: 30,
                width: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Container(
                    height: 6.0,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: CustomTextFormField(
                formController: countrySearchController,
                onChange: (search) {
                  searchCountryCodes(
                    countrySearchController.text,
                    allCountryCodes,
                  );
                },
                suffixWidget: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    countrySearchController.clear();
                    searchCountryCodes("", allCountryCodes);
                  },
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: allCountryCodes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(allCountryCodes[index].name ?? ""),
                      subtitle: Text(allCountryCodes[index].dialCode ?? ""),
                      leading: Image.asset(
                        allCountryCodes[index].flagUri ?? "",
                        package: 'country_code_picker',
                        width: 32.0,
                      ),
                      onTap: () {
// Handle country code selection here
                        countryImage.value =
                            allCountryCodes[index].flagUri ?? "";
                        countryCode.value =
                            allCountryCodes[index].dialCode ?? "";
                        Navigator.pop(context);
                        searchCountryCodes("", allCountryCodes);
                        countrySearchController.clear();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  // return {"countryImg": countryImage.value, "countryCode": countryCode.value};
}

searchCountryCodes(
  String query,
  allCountryCodes,
) {
  allCountryCodes.value.clear();
  RxList<CountryCode> allTotalCountryCodes = codes
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
  if (query.isEmpty) {
// if the search field is empty or only contains white-space, we'll display all users
    allCountryCodes.value = allTotalCountryCodes.value;
  } else {
    /// search country codes with country name , dialCode and CountryCode
    allCountryCodes.value = allTotalCountryCodes.value
        .where((user) =>
            (user.name != null &&
                user.name!.toLowerCase().contains(query.toLowerCase())) ||
            (user.dialCode != null &&
                user.dialCode!.toLowerCase().contains(query.toLowerCase())) ||
            (user.code != null &&
                user.code!.toLowerCase().contains(query.toLowerCase())))
        .toList();

// print("allCountryCodes...${allCountryCodes.value[0].name}");
  }
}
