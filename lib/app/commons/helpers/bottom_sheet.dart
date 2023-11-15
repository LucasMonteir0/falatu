import 'package:flutter/material.dart';

Future<void> bottomSheet(BuildContext context, Widget child) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) {
      return child;
    },
  );
}
