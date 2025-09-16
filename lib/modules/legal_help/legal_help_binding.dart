import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LegalHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LegalHelpController());
  }
}

class LegalHelpController extends GetxController {
  // TODO: Add legal help logic
}

