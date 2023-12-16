import 'package:flutter/material.dart';

Image networkImage(
    {required String imageUrl,
    double? height,
    double? width,
    BoxFit? fit,
    Color? color}) {
  return Image.network(imageUrl,
      height: height,
      fit: fit,
      width: width,
      color: color, errorBuilder: (_, error, ___) {
    if (error is NetworkImageLoadException) {
      if (error.statusCode == 404) {
        return Image.asset(
          'assets/images/placeholder-image.png',
          fit: fit,
          width: width,
          color: color,
        );
      }
    }
    return Image.asset(
      'assets/images/placeholder-image.png',
      fit: fit,
      width: width,
      color: color,
    ); // Show a placeholder image in case of an error.
  });
}
