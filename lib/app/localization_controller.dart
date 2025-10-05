// If missing, define the LocalizationController here
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  static const Locale bangla = Locale('bn');
  static const Locale english = Locale('en');

  var locale = bangla.obs;

  void changeLocale(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
  }
}
