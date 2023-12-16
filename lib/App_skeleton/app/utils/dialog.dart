import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,
    {String? title, String? content, List<Widget>? actionWidgets}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: title != null ? Text(title) : null,
          content: content != null ? Text(content) : null,
          actions: actionWidgets);
    },
  );
}
