import 'package:falatu_mobile/app_module.dart';
import 'package:falatu_mobile/commons/utils/resources/theme/theme.dart';
import 'package:falatu_mobile/falatu.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MaterialTheme.loadTheme();
  AppModule().dependencies();
  runApp(const FalaTu());
}
