import 'package:get/get.dart';
import 'lawyer_controller.dart';

class LawyerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LawyerController());
  }
}

