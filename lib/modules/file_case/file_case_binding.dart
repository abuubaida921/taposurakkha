import 'package:get/get.dart';
import 'file_case_controller.dart';

class FileCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FileCaseController());
  }
}

