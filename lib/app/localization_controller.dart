// If missing, define the LocalizationController here
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shared_preferences_helper.dart';

class LocalizationController extends GetxController {
  static const Locale bangla = Locale('bn');
  static const Locale english = Locale('en');

  var locale = bangla.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  void changeLocale(Locale newLocale) async {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    await SharedPreferencesHelper.setLanguageCode(newLocale.languageCode);
  }

  void _loadSavedLanguage() async {
    final code = await SharedPreferencesHelper.getLanguageCode();
    if (code == 'en') {
      locale.value = english;
      Get.updateLocale(english);
    } else if (code == 'bn') {
      locale.value = bangla;
      Get.updateLocale(bangla);
    }
  }
}
