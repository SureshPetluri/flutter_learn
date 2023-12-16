import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextStyle buildTextStyle({
  bool inherit = true,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  TextBaseline? textBaseline,
  List<Shadow>? shadows,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  String? fontFamily,
  TextOverflow? overflow,
}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    inherit: inherit,
    backgroundColor: backgroundColor,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    textBaseline: textBaseline,
    shadows: shadows,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
    fontFamily: fontFamily,
    overflow: overflow,
  );
}

class NoLeadingSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Trim leading spaces from the input value
    final trimmedValue = newValue.text.trimLeft();

    // Check if the input value has leading spaces
    if (newValue.text != trimmedValue) {
      // If there were leading spaces, return the trimmed value
      return TextEditingValue(
        text: trimmedValue,
        selection: TextSelection.collapsed(offset: trimmedValue.length),
      );
    }

    // If there were no leading spaces, return the original value
    return newValue;
  }
}

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Trim leading spaces from the input value
    final trimmedValue = newValue.text.trim();

    // Check if the input value has leading spaces
    if (newValue.text != trimmedValue) {
      // If there were leading spaces, return the trimmed value
      return TextEditingValue(
        text: trimmedValue,
        selection: TextSelection.collapsed(offset: trimmedValue.length),
      );
    }

    // If there were no leading spaces, return the original value
    return newValue;
  }
}


// inputFormatters: [
// CardFormatter(sample: "**:**:**",separator: ':')
// ],
/// using CardFormatter we can format TextFormField given text
class CardFormatter extends TextInputFormatter {
  final String sample;
  final String separator;
  CardFormatter({
    required this.sample,
    required this.separator
  });
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;
        if (newValue.text.length < sample.length &&
            sample[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: "${oldValue.text}$separator${newValue.text.substring(
                newValue.text.length - 1)}",
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}