import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackBar(
    BuildContext context, {
    String? title,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          '$title',
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
