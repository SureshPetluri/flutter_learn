import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
   CustomTextFormField({super.key,
    this.labelText,
    this.inputFormatter,
    this.suffixWidget,
    this.prefixWidget,
    this.validators,
    required this.formController,
    this.obscure = false,
    this.counterText = '',
    this.hintText,
    this.onChange,
    this.enabled = true,
    this.decorationUnderline = true,
    this.maxLines = 1,
    this.maxLength});

  final List<TextInputFormatter>? inputFormatter;
  final String? labelText;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final String? Function(String?)? validators;
  final TextEditingController formController;
  final bool obscure;
  final String counterText;
  final String? hintText;
  final int? maxLength;
  final bool enabled;
  final int maxLines;
   final bool decorationUnderline ;
  final Function(String)? onChange;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    print("ewriuyt...${widget.decorationUnderline}");

    return TextFormField(
        textAlign: TextAlign.start,

        enabled: widget.enabled,
        inputFormatters: widget.inputFormatter,
        obscureText: widget.obscure,
        controller: widget.formController,
        validator: widget.validators,
        maxLength: widget.maxLength,
        onChanged: (text) {
          widget.onChange != null ? widget.onChange!(text) : null;
        },
        maxLines: widget.maxLines,
        decoration: widget.decorationUnderline
            ? buildUnderlineInputDecoration()
            : buildInputDecoration(),
      );
    /* ],
    );*/
  }

  InputDecoration buildUnderlineInputDecoration() {
    return InputDecoration(
        alignLabelWithHint: true,
        counterText: widget.counterText,
        contentPadding: const EdgeInsets.only(top: 15, left: 10.0),
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.suffixWidget,
        prefixIcon: widget.prefixWidget);
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
        alignLabelWithHint: true,
        counterText: widget.counterText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green, // Color of the bottom line
            width: 2.0, // Width of the bottom line
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Color of the bottom line
            width: 2.0, // Width of the bottom line
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Color of the bottom line
            width: 2.0, // Width of the bottom line
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent, // Color of the bottom line
            width: 2.0, // Width of the bottom line
          ),
        ),
        contentPadding: EdgeInsets.only(top: 15, left: 10.0),
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
        suffixIcon: widget.suffixWidget,
        prefixIcon: widget.prefixWidget);
  }
}
