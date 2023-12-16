import 'package:flutter/material.dart';

SizedBox sizedBoxH5() =>const SizedBox(height: 5,);
SizedBox sizedBoxH10() =>const SizedBox(height: 10,);
SizedBox sizedBoxH15() =>const SizedBox(height: 15,);
SizedBox sizedBoxH20() =>const SizedBox(height: 20,);
SizedBox sizedBoxH25() =>const SizedBox(height: 25,);
SizedBox sizedBoxH30() =>const SizedBox(height: 30,);
SizedBox sizedBoxH35() =>const SizedBox(height: 35,);
SizedBox sizedBoxH40() =>const SizedBox(height: 40,);

SizedBox sizedBoxW5() =>const SizedBox(width: 5,);
SizedBox sizedBoxW10() =>const SizedBox(width: 10,);
SizedBox sizedBoxW15() =>const SizedBox(width: 15,);
SizedBox sizedBoxW20() =>const SizedBox(width: 20,);
SizedBox sizedBoxW25() =>const SizedBox(width: 25,);
SizedBox sizedBoxW30() =>const SizedBox(width: 30,);
SizedBox sizedBoxW35() =>const SizedBox(width: 35,);
SizedBox sizedBoxW40() =>const SizedBox(width: 40,);

Image networkImage(
    {required String imageUrl,
      double? height,
      double? width,
      BoxFit? fit,
      Color? color}) {
  return Image.network(
    imageUrl, height: height,
    fit: fit,
    width: width,
    color: color,
    errorBuilder: (_, __, ___) => Image.asset(
      'assets/images/placeholder-image.png',
      fit: fit,
      width: width,
      color: color,
    ), // Show a placeholder image in case of an error.
  );
}

